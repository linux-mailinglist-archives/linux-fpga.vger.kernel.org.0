Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FD941B292
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Sep 2021 17:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241497AbhI1PEz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 28 Sep 2021 11:04:55 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:39504 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241473AbhI1PEx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 28 Sep 2021 11:04:53 -0400
Received: by mail-pj1-f48.google.com with SMTP id ce20-20020a17090aff1400b0019f13f6a749so1656800pjb.4
        for <linux-fpga@vger.kernel.org>; Tue, 28 Sep 2021 08:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dpfo9Ttq7lUevoJ1YXOS9MX+eF23I+bKYFa7ytCzkjA=;
        b=mn7FzJLvUAvQXlt1gn6BmK+6879yi+jEv0UXBedJypRPaagA5YUdIdsBUber8o8Yal
         UmFRMNRaMV6Hi6Bgakp3NRjBXfAlxiVeqWXrOM4/HvcO1ajx2uxaTEkM/jxRbsHjzM6i
         FvdAYQXKIB6HvWTdI5hRUsLah2ylP8ZdUzWjdiO8PRG9bywt5SiliOqtOaXL3utfXcOS
         iIvYnuo0OYklnG47DJHwZIPU0UgSp8U6+f3z2xS0/OC4l6SxJazSdeSIqhLkdC5WwVlE
         wSboGVLg6MJntrhpTQ4vzaRMMSVxD6ze0cG0mOPvkFUKtP9zPRa9epw0HSGoB9Vos+4M
         Ip6g==
X-Gm-Message-State: AOAM533u0SAmqrsjRJGG4ZMdCVPFHpCJ7bOWXStIVFlXlJgF3fWMSBXW
        J5jxbRXcvld9KEpiy7xTUOG7u3djt5k=
X-Google-Smtp-Source: ABdhPJyMyOevWB8pXSt+wh1AMpdOoeNq3urwAKqkZL+ySDqx0g5+tVGs1K4Fo4jbNVtXZnvkfWaL3A==
X-Received: by 2002:a17:902:bb81:b0:12d:a7ec:3d85 with SMTP id m1-20020a170902bb8100b0012da7ec3d85mr5591463pls.17.1632841393406;
        Tue, 28 Sep 2021 08:03:13 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id s19sm2850413pjg.35.2021.09.28.08.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:03:07 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>
Cc:     moritzf@google.com, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] fpga: ice40-spi: Add SPI device ID table
Date:   Tue, 28 Sep 2021 08:02:27 -0700
Message-Id: <20210927134403.32328-1-broonie@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928150227.22275-1-mdf@kernel.org>
References: <20210928150227.22275-1-mdf@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; h=from:subject; bh=2f2az81V1apVIpFf6zg+nb0WROwmDqCPzQ0XWtF2wpg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhUcpTcZCsUehrxUSbEqszdthywRnBexVDxSyvDVQr abtMY9qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVHKUwAKCRAk1otyXVSH0Ns8B/ 9kvvEYg0YDkKubU77Vw74myo4bT1ddWo79aIh+MzOKCsUAPqAxp+yEW9JRX5GtJqYYxcgClTRM3lfN sGuj286E8RTUgyJ6Nf5tOi1J94XC3HqVvVwOKgc1K+ZMn/0m3wHX/n5rbfhX9rI06NIdA82Bjo2S6T 0wOxMbcxJLOKeREY2n7KLDentTVqTE6jSyDsz1reL3aEpyEdzmxWF2tfKD9xGC7u3rPQ1uh65vZ0aQ OzBkCuO5yWwjSgSFHwE4JnsudfRp0K0UG72uyoMsw1uWWau390uHrojKFJJcQDYxydGJ1ZPUnWGmIR 29e3+El3M5ENDvmo/O33UVoqr0zcgB
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

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
