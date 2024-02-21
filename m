Return-Path: <linux-fpga+bounces-285-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFECE85E6FF
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Feb 2024 20:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A701C2348A
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Feb 2024 19:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A7A8593E;
	Wed, 21 Feb 2024 19:13:31 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6626A1097B
	for <linux-fpga@vger.kernel.org>; Wed, 21 Feb 2024 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542811; cv=none; b=sviTBcojR5nvrG/trccB3PMXya0wQ5w4ydNVYe+yUSr0kM9Oo+dMBabX0ApocHznr+eEQ6oWdvqp6wNzA6mJ2XXCen7BOVBVmN3RTOI3nLSesTCGTM3yRUF1WM9GRQolcyyD4O2Y4bflO6Jp/o746GVk5ZG39zYbxs0uQy4jFq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542811; c=relaxed/simple;
	bh=jefV61l/T0TatZNUI9/rQ+/DLxxeKsWDtFNb40LJrcw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LCLnVdqmRns4ghUkZ3U5XYXTGNx8jGVSt+fQ55FQgFYnutBNUvcCtN36kIkrbxg9L4uimC5cweafTg2qpMrmpk0QsugspYgeorM1Gl2zdlhsULR0vC5GhCIdNUNn6xvAJy0XPh5F9pHv+yDVjBUugqLa3n1VHcg9CPdI50abJr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rcs1T-000155-EG; Wed, 21 Feb 2024 20:12:51 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: conor.dooley@microchip.com,
	v.georgiev@metrotek.ru,
	mdf@kernel.org,
	hao.wu@intel.com,
	yilun.xu@intel.com,
	trix@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Cc: linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] dt-bindings: fpga: microchip,mpf-spi-fpga-mgr: document CPOL/CPHA support
Date: Wed, 21 Feb 2024 20:12:47 +0100
Message-Id: <20240221191247.3643671-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fpga@vger.kernel.org

Microchip FPGAs can communicate in different modes, so document them to
avoid dt-validate warnings.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 .../devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
index a157eecfb5fc..bb9a7d16db60 100644
--- a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
+++ b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
@@ -22,6 +22,9 @@ properties:
     description: SPI chip select
     maxItems: 1
 
+  spi-cpol: true
+  spi-cpha: true
+
 required:
   - compatible
   - reg
-- 
2.39.2


