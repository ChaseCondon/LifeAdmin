package dev.chasecondon.lifeadmin

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform