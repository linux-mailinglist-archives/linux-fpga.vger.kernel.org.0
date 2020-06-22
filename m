Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC3A20383F
	for <lists+linux-fpga@lfdr.de>; Mon, 22 Jun 2020 15:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgFVNhj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 22 Jun 2020 09:37:39 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:56434 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728203AbgFVNhi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 22 Jun 2020 09:37:38 -0400
Received: from [37.160.94.17] (port=64520 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jnMdi-000DM3-9b; Mon, 22 Jun 2020 15:37:34 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 1/2] dt-bindings: fpga: xilinx-slave-serial: add optional INIT_B GPIO
Date:   Mon, 22 Jun 2020 15:37:22 +0200
Message-Id: <20200622133723.23326-1-luca@lucaceresoli.net>
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

The INIT_B is used by the 6 and 7 series to report the programming status,
providing more control and information about programming errors.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes in v2:
 - rename init_b-gpios to init-b-gpios (Rob Herring suggested to not use '_'
   in property names)
---
 .../devicetree/bindings/fpga/xilinx-slave-serial.txt       | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
index 9f103f3872e8..5ef659c1394d 100644
--- a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
+++ b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
@@ -16,6 +16,10 @@ Required properties:
 - prog_b-gpios: config pin (referred to as PROGRAM_B in the manual)
 - done-gpios: config status pin (referred to as DONE in the manual)
 
+Optional properties:
+- init-b-gpios: initialization status and configuration error pin
+                (referred to as INIT_B in the manual)
+
 Example for full FPGA configuration:
 
 	fpga-region0 {
@@ -40,7 +44,8 @@ Example for full FPGA configuration:
 			spi-max-frequency = <60000000>;
 			spi-cpha;
 			reg = <0>;
-			done-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
 			prog_b-gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
+			init-b-gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
+			done-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
 		};
 	};
-- 
2.27.0

