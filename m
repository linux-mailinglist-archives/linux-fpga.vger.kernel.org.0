Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649541F6F7B
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Jun 2020 23:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgFKVdT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Jun 2020 17:33:19 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:60365 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbgFKVdT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 11 Jun 2020 17:33:19 -0400
Received: from [78.134.85.74] (port=40536 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jjUUN-000C9m-S7; Thu, 11 Jun 2020 23:11:55 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 1/5] dt-bindings: fpga: xilinx-slave-serial: valid for the 7 Series too
Date:   Thu, 11 Jun 2020 23:11:40 +0200
Message-Id: <20200611211144.9421-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
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
 .../devicetree/bindings/fpga/xilinx-slave-serial.txt     | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
index cfa4ed42b62f..9f103f3872e8 100644
--- a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
+++ b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
@@ -1,11 +1,14 @@
 Xilinx Slave Serial SPI FPGA Manager
 
-Xilinx Spartan-6 FPGAs support a method of loading the bitstream over
-what is referred to as "slave serial" interface.
+Xilinx Spartan-6 and 7 Series FPGAs support a method of loading the
+bitstream over what is referred to as "slave serial" interface.
 The slave serial link is not technically SPI, and might require extra
 circuits in order to play nicely with other SPI slaves on the same bus.
 
-See https://www.xilinx.com/support/documentation/user_guides/ug380.pdf
+See:
+- https://www.xilinx.com/support/documentation/user_guides/ug380.pdf
+- https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
+- https://www.xilinx.com/support/documentation/application_notes/xapp583-fpga-configuration.pdf
 
 Required properties:
 - compatible: should contain "xlnx,fpga-slave-serial"
-- 
2.27.0

