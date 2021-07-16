Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC63CB825
	for <lists+linux-fpga@lfdr.de>; Fri, 16 Jul 2021 15:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbhGPN5z (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 16 Jul 2021 09:57:55 -0400
Received: from first.geanix.com ([116.203.34.67]:35082 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240023AbhGPN5y (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 16 Jul 2021 09:57:54 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 707404C7C4C;
        Fri, 16 Jul 2021 13:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1626443697; bh=i/+X3gP3HwH8rkbJsejt4h75hhaGndC3LlZu0F+wpag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dEP5kVmeUMyhv+rctPytzJjNe74nGodGETOOdW0v2U0l3Z+fwH4AzbrBdg014g6CI
         4KLT17pOsGBrZEDSC6eGSIobuF3/fRESFMMP2CG2IHwgUFMXrWuqfJwkCrZAPuz+fL
         ze4GNxWWPDqJR6mibu8MbuEalMZemVun7RZPI1eacKBFg7kZTEy071tRHFoLiWlaEq
         hiFqJsafRUhi042WRh4HFl7WlLm+mDdc6T9Y7T1WRilG1bwwSEPd+Z1jzz3wu/GX9M
         tuuNi7S7oH8qPeqtBnJecaHoihJn8/Tg456RkVXqIzKapNi55NrfFN2LmtD/lqBS5Y
         TSW88krJm3E7Q==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v5 2/3] spi: spi-altera-dfl: support n5010 feature revision
Date:   Fri, 16 Jul 2021 15:54:40 +0200
Message-Id: <20210716135441.3235863-3-martin@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210716135441.3235863-1-martin@geanix.com>
References: <20210716135441.3235863-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Martin Hundebøll <mhu@silicom.dk>

The Max10 BMC on the Silicom n5010 PAC is slightly different than the
existing BMCs, so use a dedicated feature revision detect it.

Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
---

Changes since v4:
 * Moved spi board_info structure from global/static scope
   to function/stack scope

Changes since v3:
 * Changed "BMC's" to "BMCs"
 * Added Moritz' Reviewed-by

Changes since v2:
 * None

Changes since v1:
 * use feature revision from struct dfl_device instead of reading it
   from io-mem

 drivers/spi/spi-altera-dfl.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
index 39a3e1a032e0..44fc9ee13fc7 100644
--- a/drivers/spi/spi-altera-dfl.c
+++ b/drivers/spi/spi-altera-dfl.c
@@ -104,13 +104,6 @@ static const struct regmap_config indirect_regbus_cfg = {
 	.reg_read = indirect_bus_reg_read,
 };
 
-static struct spi_board_info m10_bmc_info = {
-	.modalias = "m10-d5005",
-	.max_speed_hz = 12500000,
-	.bus_num = 0,
-	.chip_select = 0,
-};
-
 static void config_spi_master(void __iomem *base, struct spi_master *master)
 {
 	u64 v;
@@ -130,6 +123,7 @@ static void config_spi_master(void __iomem *base, struct spi_master *master)
 
 static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 {
+	struct spi_board_info board_info = { 0 };
 	struct device *dev = &dfl_dev->dev;
 	struct spi_master *master;
 	struct altera_spi *hw;
@@ -170,9 +164,18 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 		goto exit;
 	}
 
-	if (!spi_new_device(master,  &m10_bmc_info)) {
+	if (dfl_dev->revision == FME_FEATURE_REV_MAX10_SPI_N5010)
+		strscpy(board_info.modalias, "m10-n5010", SPI_NAME_SIZE);
+	else
+		strscpy(board_info.modalias, "m10-d5005", SPI_NAME_SIZE);
+
+	board_info.max_speed_hz = 12500000;
+	board_info.bus_num = 0;
+	board_info.chip_select = 0;
+
+	if (!spi_new_device(master, &board_info)) {
 		dev_err(dev, "%s failed to create SPI device: %s\n",
-			__func__, m10_bmc_info.modalias);
+			__func__, board_info.modalias);
 	}
 
 	return 0;
-- 
2.31.0

