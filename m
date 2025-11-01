Return-Path: <linux-fpga+bounces-1399-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FD4C285ED
	for <lists+linux-fpga@lfdr.de>; Sat, 01 Nov 2025 20:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 352E14E330C
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Nov 2025 19:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80D72FC887;
	Sat,  1 Nov 2025 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bROy2xW1"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CDEF50F;
	Sat,  1 Nov 2025 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762024132; cv=none; b=iDmOkUx+XVRuXo5rA98bhPhRhSCTVIM7OqYZOqN3GrixGqYm//4nlO/mZwUqPX2fIjEU6wo/ej7tfqFqTw7zbIPh2QRvICJ+sXqWKwe4qpAi06qSWhoOkEribEEUxswLzfmFUIZsJCEMOFWqwILMe+67ek1E+4FPbXxEkaUU9p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762024132; c=relaxed/simple;
	bh=0mGBzrzv6jnE6T7BFP57GnWz7zVRobJH9dhCr6K0970=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrFj6yLbzhFPNpRCY85uqVNJ2RbtMKru6JFsVcRF5ezrzsXbekrXD0tWwxdm+wziy4F/NDlfMuU8U7xPeCN0XGKvhmOsiT11OvAneXpprGzhZlhDTvOPSaZ3i6oTHJU6DtoICm6y2mhQlOyvmnprE0HNmG5BLs0XRBhr9nqr0Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bROy2xW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F52C4CEF1;
	Sat,  1 Nov 2025 19:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762024132;
	bh=0mGBzrzv6jnE6T7BFP57GnWz7zVRobJH9dhCr6K0970=;
	h=From:To:Cc:Subject:Date:From;
	b=bROy2xW1qi/BkCp5lBMVuQWnVAelxa/aDeBK8HLK7qeZ+UJ/QXux9pJ4fPzgPcOgw
	 4YVSclmuuXr2P+uQCfE0imq9xgZKrcqO9DXSiKPgyV5kuXHjKOnqrLont1cqaA1t/S
	 2qVOLgiAf9ypDZGwFjPmwIXlwLocWqj5AjjwexDBJ8u+AOn2lZwVlQZP+as0R4d/fz
	 gqdG+KQ9IViBFw0CNKd6eQUa7nIUoFymriw9vyVBk/KINCZkZ5zyiv6eOhE2+VbZPq
	 +A5VPTOABbH6o4Dbhz61UI7kZMkvqRvFbkYnGaLMIdEyDgCTc8HAE7qaJsAdA2NpZI
	 ObLlClHegs9Cw==
From: Dinh Nguyen <dinguyen@kernel.org>
To: devicetree@vger.kernel.org
Cc: dinguyen@kernel.org,
	linux-fpga@vger.kernel.org,
	yilun.xu@intel.com,
	trix@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowskii+dt@linaro.org,
	conor+dt@kernel.org,
	michal.simek@amd.com
Subject: [PATCH] dt-bindings: fpga: update link for Altera's and AMD partial recon
Date: Sat,  1 Nov 2025 14:08:48 -0500
Message-ID: <20251101190848.24271-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The link is giving the 404 error, so use the correct link for the
documents

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 Documentation/devicetree/bindings/fpga/fpga-region.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.yaml b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
index 7d2d3b7aa4b7..98e7c311c0c8 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.yaml
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
@@ -215,9 +215,9 @@ description: |
   FPGA Bridges that exist on the FPGA fabric prior to the partial reconfiguration.
 
   --
-  [1] www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/ug/ug_partrecon.pdf
+  [1] https://www.intel.com/programmable/technical-pdfs/683404.pdf
   [2] tspace.library.utoronto.ca/bitstream/1807/67932/1/Byma_Stuart_A_201411_MAS_thesis.pdf
-  [3] https://www.xilinx.com/support/documentation/sw_manuals/xilinx14_1/ug702.pdf
+  [3] https://docs.amd.com/v/u/en-US/ug702
 
 properties:
   $nodename:
-- 
2.42.0.411.g813d9a9188


