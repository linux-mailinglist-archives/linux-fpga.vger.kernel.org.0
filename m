Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2613BBB0F
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Jul 2021 12:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhGEKTn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Jul 2021 06:19:43 -0400
Received: from first.geanix.com ([116.203.34.67]:59054 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhGEKTm (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 5 Jul 2021 06:19:42 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 3FB344C5384;
        Mon,  5 Jul 2021 10:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1625480223; bh=H4GcDaNTIdp5tc97lgwlIuPmAmCIKHBz49GfQnVHrfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OpZCt3Kna/x9L9o3P1o/PnJ20uEn9R0brape96y84z5wnLRSEx7EDNIAs7TXTU5DN
         mUK96fTMbZs4WSm0ZQGEGjEFiccrrK8gxhawsFeRNgFiutOwhqACo9GtHzAxlsRy5V
         y4r5uIym7qQILPuUKSCIJteFpz1BYWPljlWS9A9uXVEGJEAL283rArmc8ncV8xMzGH
         X15VCejRbb0+EidITrYt9yQ5jYCWMFaLhSRcGjOn4R1uswgmqV/ISj8ed8sZp0CwzR
         3hw9bApOEXk4+Oar4xx55b8UUvuJvDsYIQH6U7ijE0I0GcEi1iaDo7u/g8Lz9qm/ZS
         GAf8/2dT8RilA==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v4 2/4] spi: spi-altera-dfl: support n5010 feature revision
Date:   Mon,  5 Jul 2021 12:16:43 +0200
Message-Id: <20210705101645.2040106-3-martin@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210705101645.2040106-1-martin@geanix.com>
References: <20210705101645.2040106-1-martin@geanix.com>
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

Changes since v3:
 * Changed "BMC's" to "BMCs"
 * Added Moritz' Reviewed-by

Changes since v2:
 * None

Changes since v1:
 * use feature revision from struct dfl_device instead of reading it
   from io-mem

 drivers/spi/spi-altera-dfl.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
index 3e32e4fe5895..f6cf7c8d9dac 100644
--- a/drivers/spi/spi-altera-dfl.c
+++ b/drivers/spi/spi-altera-dfl.c
@@ -111,6 +111,13 @@ static struct spi_board_info m10_bmc_info = {
 	.chip_select = 0,
 };
 
+static struct spi_board_info m10_n5010_bmc_info = {
+	.modalias = "m10-n5010",
+	.max_speed_hz = 12500000,
+	.bus_num = 0,
+	.chip_select = 0,
+};
+
 static void config_spi_master(void __iomem *base, struct spi_master *master)
 {
 	u64 v;
@@ -130,6 +137,7 @@ static void config_spi_master(void __iomem *base, struct spi_master *master)
 
 static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 {
+	struct spi_board_info *board_info = &m10_bmc_info;
 	struct device *dev = &dfl_dev->dev;
 	struct spi_master *master;
 	struct altera_spi *hw;
@@ -172,9 +180,12 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 		goto exit;
 	}
 
-	if (!spi_new_device(master,  &m10_bmc_info)) {
+	if (dfl_dev->revision == FME_FEATURE_REV_MAX10_SPI_N5010)
+		board_info = &m10_n5010_bmc_info;
+
+	if (!spi_new_device(master, board_info)) {
 		dev_err(dev, "%s failed to create SPI device: %s\n",
-			__func__, m10_bmc_info.modalias);
+			__func__, board_info->modalias);
 	}
 
 	return 0;
-- 
2.31.0

