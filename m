Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F003D97C7
	for <lists+linux-fpga@lfdr.de>; Wed, 28 Jul 2021 23:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhG1Vv7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 28 Jul 2021 17:51:59 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:56100
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230156AbhG1Vv7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 28 Jul 2021 17:51:59 -0400
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net [80.193.200.194])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id EE8283F228;
        Wed, 28 Jul 2021 21:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627509116;
        bh=7A9PJEk1zQ7CyaYPHPeDtT58e8/56nw5lQvVXu6g2gA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=wZtz7qeijstDNi9RFF4FSHttSaYpcry7t4QXm7VKXyLfdNOWUvFg+70aU9VMFJeFv
         30k5g1e1xg8wyXX4JpX4ahHwW7Abl88PuL9z80mcyAdVbDAvjwc63/LZm9qtrdeub7
         5VvJcv/kTGgdhjqGA+OQFn1hTNsBccdEnV4V9DqnV7+9fNk4DnXfh65T70Z9U5FsLu
         3S5O4JEQ9fOiITcR/mZFVuQUHF1Nfad6tEm5weIjWoby1G/uNpvMyju2LTOwrAaog1
         MsFQFsOocp7i0XYsrhQD7hn7/dY8q81RiVweaFwm2SfNu8i7A0ELP4qMU7Sh3EZE6S
         o+TQ2LvrNRCCg==
From:   Colin King <colin.king@canonical.com>
To:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: Fix spelling mistake "eXchnage" -> "exchange" in Kconfig
Date:   Wed, 28 Jul 2021 22:51:50 +0100
Message-Id: <20210728215150.191914-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/fpga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 16793bfc2bb4..991b3f361ec9 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -119,7 +119,7 @@ config XILINX_PR_DECOUPLER
 	depends on HAS_IOMEM
 	help
 	  Say Y to enable drivers for Xilinx LogiCORE PR Decoupler
-	  or Xilinx Dynamic Function eXchnage AIX Shutdown Manager.
+	  or Xilinx Dynamic Function eXchange AIX Shutdown Manager.
 	  The PR Decoupler exists in the FPGA fabric to isolate one
 	  region of the FPGA from the busses while that region is
 	  being reprogrammed during partial reconfig.
-- 
2.31.1

