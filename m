Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B61E419550
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Sep 2021 15:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhI0Nqa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 Sep 2021 09:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234605AbhI0Nq3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 27 Sep 2021 09:46:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5036460240;
        Mon, 27 Sep 2021 13:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632750291;
        bh=2f2az81V1apVIpFf6zg+nb0WROwmDqCPzQ0XWtF2wpg=;
        h=From:To:Cc:Subject:Date:From;
        b=kA1fDWuGAKvN0RTMFV8QB5Q4xrxAj6PjvmZfrCIqxXtW3HQOHVyjdKwOR1Q6RLpn9
         Qsej7rZUJUADj8Gygl0IeAj/ZZFpImlHvzaYc2lQMf7bq/h+Gu06qWeBOBW5FknAyl
         j2s0bDIFvjqCp+L8D83keGJ4R3+w4MH2jap8EnM6ira+gwQKMNuecbiBY8f0e77iU4
         uTIZqp5Ex+Wiq15KMaWjDca5YSjc5sGfON8PTfk56Topq3iQCdMUWDQuXnt42tyuR8
         UzoE5r4arhIBf0PNc7PvsEwoB0e86KwHUtdhOdj894upL75UuRGBIplATs8iRz0M5/
         IWqxDALQjmYww==
From:   Mark Brown <broonie@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>
Cc:     linux-fpga@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] fpga: ice40-spi: Add SPI device ID table
Date:   Mon, 27 Sep 2021 14:44:03 +0100
Message-Id: <20210927134403.32328-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; h=from:subject; bh=2f2az81V1apVIpFf6zg+nb0WROwmDqCPzQ0XWtF2wpg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhUcpTcZCsUehrxUSbEqszdthywRnBexVDxSyvDVQr abtMY9qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVHKUwAKCRAk1otyXVSH0Ns8B/ 9kvvEYg0YDkKubU77Vw74myo4bT1ddWo79aIh+MzOKCsUAPqAxp+yEW9JRX5GtJqYYxcgClTRM3lfN sGuj286E8RTUgyJ6Nf5tOi1J94XC3HqVvVwOKgc1K+ZMn/0m3wHX/n5rbfhX9rI06NIdA82Bjo2S6T 0wOxMbcxJLOKeREY2n7KLDentTVqTE6jSyDsz1reL3aEpyEdzmxWF2tfKD9xGC7u3rPQ1uh65vZ0aQ OzBkCuO5yWwjSgSFHwE4JnsudfRp0K0UG72uyoMsw1uWWau390uHrojKFJJcQDYxydGJ1ZPUnWGmIR 29e3+El3M5ENDvmo/O33UVoqr0zcgB
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Currently autoloading for SPI devices does not use the DT ID table, it uses
SPI modalises. Supporting OF modalises is going to be difficult if not
impractical, an attempt was made but has been reverted, so ensure that
module autoloading works for this driver by adding a SPI ID table.

Fixes: 96c8395e2166 ("spi: Revert modalias changes")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/fpga/ice40-spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 69dec5af23c3..029d3cdb918d 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -192,12 +192,19 @@ static const struct of_device_id ice40_fpga_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ice40_fpga_of_match);
 
+static const struct spi_device_id ice40_fpga_spi_ids[] = {
+	{ .name = "ice40-fpga-mgr", },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, ice40_fpga_spi_ids);
+
 static struct spi_driver ice40_fpga_driver = {
 	.probe = ice40_fpga_probe,
 	.driver = {
 		.name = "ice40spi",
 		.of_match_table = of_match_ptr(ice40_fpga_of_match),
 	},
+	.id_table = ice40_fpga_spi_ids,
 };
 
 module_spi_driver(ice40_fpga_driver);
-- 
2.20.1

