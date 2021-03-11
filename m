Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07BA3377A3
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Mar 2021 16:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbhCKP2K (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Mar 2021 10:28:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34310 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbhCKP1s (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 11 Mar 2021 10:27:48 -0500
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lKNE3-0005jN-85
        for linux-fpga@vger.kernel.org; Thu, 11 Mar 2021 15:27:47 +0000
Received: by mail-ed1-f72.google.com with SMTP id h5so10069258edf.17
        for <linux-fpga@vger.kernel.org>; Thu, 11 Mar 2021 07:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LkS1dLaLUNf0Tu13eWfZQBLP6fiimg7+EWMMMS6XyYM=;
        b=nC0yNBMV7csl+K+v9eH9hqBrI0WJTkzhCudMLOPWu/4E/CePKzG6KPDYIx26Tnh0qJ
         AzoM8IzeiAvyeTEQBnCNHZ2fCblfRsiME9xxpRMq6RlO+MalpwgqAhtgpSP16kxfBozu
         FTPhVNO0yEg7YBeRKsnjaAuyfGx/6vIg8WT3AIkRZTTFR75FZEgIrtjQJbzwSwLa97oD
         ZV2KvWA7fpdaIIIx5hzeTrfUPvceDvgsyVn1U6EAcPNLztMIJXNUD6xu063jfVm65iXY
         yVFTJWb3wEWQX3rSgiQ+/7uYHig0c9edxoMSOcTKfph0P306l/x53iCXKBVlRpzWapXR
         N7HA==
X-Gm-Message-State: AOAM533dhbPZDsT/ThNCmLSjGWwoowdlV6AtHA2A/2KucAKu2RrgWYDR
        W3ReGPDr4UpO5QogM+Z7EPJTSTlGRLzMuoMRZFM0cawHsxTo6TwyHR5+OQDvl7Uz28xLUfJwx/X
        ufeNaPwBTz9ip7PGnBI7PCk2GXoD+nYEtzFQk3Dk=
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr9186802edu.268.1615476466826;
        Thu, 11 Mar 2021 07:27:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiRng9hU7KaBQ9hI2y61WSuJDlIqArf08ScSxAu55vb9/puMamEp/Rnnmw5+yqMGNTUgkwAA==
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr9186761edu.268.1615476466574;
        Thu, 11 Mar 2021 07:27:46 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id t15sm1518545edc.34.2021.03.11.07.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:27:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v3 15/15] ARM: socfpga: drop ARCH_SOCFPGA
Date:   Thu, 11 Mar 2021 16:27:44 +0100
Message-Id: <20210311152744.1318653-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311152545.1317581-1-krzysztof.kozlowski@canonical.com>
References: <20210311152545.1317581-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Simplify 32-bit and 64-bit Intel SoCFPGA Kconfig options by having only
one for both of them.  After conversion of all
drivers to use the new ARCH_INTEL_SOCFPGA, the remaining ARM option can
be removed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 arch/arm/configs/socfpga_defconfig  | 2 +-
 arch/arm/mach-socfpga/Kconfig       | 8 ++------
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 3823da605430..591b15164e3d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -79,7 +79,7 @@ CONFIG_ARCH_MSM8960=y
 CONFIG_ARCH_MSM8974=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_RENESAS=y
-CONFIG_ARCH_SOCFPGA=y
+CONFIG_ARCH_INTEL_SOCFPGA=y
 CONFIG_PLAT_SPEAR=y
 CONFIG_ARCH_SPEAR13XX=y
 CONFIG_MACH_SPEAR1310=y
diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 0c60eb382c80..2d9404ea52c6 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -9,7 +9,7 @@ CONFIG_NAMESPACES=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
 CONFIG_PROFILING=y
-CONFIG_ARCH_SOCFPGA=y
+CONFIG_ARCH_INTEL_SOCFPGA=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index e43ed0ca6860..43ddec677c0b 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
-menuconfig ARCH_SOCFPGA
+menuconfig ARCH_INTEL_SOCFPGA
 	bool "Altera SOCFPGA family"
 	depends on ARCH_MULTI_V7
-	select ARCH_INTEL_SOCFPGA
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
@@ -20,10 +19,7 @@ menuconfig ARCH_SOCFPGA
 	select PL310_ERRATA_753970 if PL310
 	select PL310_ERRATA_769419
 
-if ARCH_SOCFPGA
-config ARCH_INTEL_SOCFPGA
-	bool
-
+if ARCH_INTEL_SOCFPGA
 config SOCFPGA_SUSPEND
 	bool "Suspend to RAM on SOCFPGA"
 	help
-- 
2.25.1

