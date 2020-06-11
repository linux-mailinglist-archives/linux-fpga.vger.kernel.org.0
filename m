Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2261B1F6F78
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Jun 2020 23:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgFKVau (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Jun 2020 17:30:50 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:54485 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbgFKVat (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 11 Jun 2020 17:30:49 -0400
Received: from [78.134.85.74] (port=40536 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jjUUO-000C9m-8M; Thu, 11 Jun 2020 23:11:56 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 2/5] fpga manager: xilinx-spi: valid for the 7 Series too
Date:   Thu, 11 Jun 2020 23:11:41 +0200
Message-Id: <20200611211144.9421-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200611211144.9421-1-luca@lucaceresoli.net>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The Xilinx 7-series uses the same protocol, mention that.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/fpga/xilinx-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 272ee0c22822..79106626c3f8 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Xilinx Spartan6 Slave Serial SPI Driver
+ * Xilinx Spartan6 and 7 Series Slave Serial SPI Driver
  *
  * Copyright (C) 2017 DENX Software Engineering
  *
-- 
2.27.0

