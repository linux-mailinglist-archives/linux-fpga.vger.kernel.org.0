Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72D83AE3BB
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Jun 2021 09:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFUHIu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Jun 2021 03:08:50 -0400
Received: from first.geanix.com ([116.203.34.67]:54066 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230061AbhFUHIp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Jun 2021 03:08:45 -0400
Received: from 185.17.218.86 (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 614984C3B81;
        Mon, 21 Jun 2021 07:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=silicom.dk; s=first;
        t=1624259188; bh=NhA6xE7NEXRr0tKmSLpxBt1noGzj8TyllqDWmLnCoi0=;
        h=From:To:Cc:Subject:Date;
        b=K6ZGR/cVU5lkaQPpBN+yMHP8B403yaiEQlyJHRt4sIaVrLDt6IumIHr82h/jNBse1
         HQTNPrkzfvxagUvxZpNVjEEJJCdl519Odkh23U+3RQOLDyA1IAZEEXoR2vOtKUPbBu
         GILixYnLyt2KhYrtsrbmo8oZ8umywKdzzr1G/wMaAyn3KsnNmcKU9jVcn2ogqADDRb
         4LGM5/j8eVDuM3+U8Tov8l/+q0QmpSKrUIL0My4ZeE1YnmJ5y+KrOzfvNehmEPEjbG
         7SHM//TBb6YgyBD3vrUpcu4tjwRN15HrtRNXM+ejnPtcGbI4ZvWfzKJq4dnvTVGyCW
         oQnSDjbLM9WYw==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@geanix.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 0/4] fpga/mfd/hwmon: Initial support for Silicom N5010 PAC
Date:   Mon, 21 Jun 2021 09:06:17 +0200
Message-Id: <20210621070621.431482-1-mhu@silicom.dk>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,TVD_RCVD_IP,TVD_RCVD_IP4,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Martin Hundebøll <mhu@geanix.com>

This is an initial set of patches for the Silciom N5010 programmable
accelerated card adding support for reading out sensors.

I'm not really sure if these should be taken through each of the
affected trees separately, or just by fpga collectively?

Based on current master.

// Martin

Debarati Biswas (1):
  fpga: dfl: Move DFH header register macros to linux/dfl.h

Martin Hundebøll (3):
  fpga: dfl: pci: add device IDs for Silicom N501x PAC cards
  spi: spi-altera-dfl: support n5010 feature revision
  hwmon: intel-m10-bmc: add sensor support for Silicom N5010 card

 drivers/fpga/dfl-pci.c              |   5 ++
 drivers/fpga/dfl.h                  |  48 +-----------
 drivers/hwmon/intel-m10-bmc-hwmon.c | 116 ++++++++++++++++++++++++++++
 drivers/mfd/intel-m10-bmc.c         |  12 ++-
 drivers/spi/spi-altera-dfl.c        |  15 +++-
 include/linux/dfl.h                 |  52 +++++++++++++
 6 files changed, 198 insertions(+), 50 deletions(-)

-- 
2.31.0

