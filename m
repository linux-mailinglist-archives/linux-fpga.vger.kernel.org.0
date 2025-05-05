Return-Path: <linux-fpga+bounces-1192-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE2BAAB017
	for <lists+linux-fpga@lfdr.de>; Tue,  6 May 2025 05:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4730E3B2E2A
	for <lists+linux-fpga@lfdr.de>; Tue,  6 May 2025 03:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB675303990;
	Mon,  5 May 2025 23:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaKgyIT0"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3353AEC4E;
	Mon,  5 May 2025 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487206; cv=none; b=ZjmpPMtQqpjZe+UWOt2Dsgr3sdcGlAXAbtCFEDaml6fd/ZRDvTsPzi2t7flUB1jMpHbnXzrxHt2ZMYLOXKbRJuXLmWVYZ4x1GFUWRMBUhW3/Lg3+tb/cwjnEbyzN2JPLBKM9sNUXAU6dLUiEopXBgm0plb+FyfG0kAUlaEV3/mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487206; c=relaxed/simple;
	bh=MNGlNLSARosDWL9/qPbCvoRohfJjlFuxy37g7ldF6l0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RVUzRhKDd4MMXoaorU7+f/fnOgiKxQaaT1U+hKTC4tHa0B5YuwDBZYafyknHLhfl3o9wrXGspWs+ENsYQ6FI7Wrw0vWoVrt+NQAPxnJ6K0Nvo9j0WjYYkqMjXnPND0LysymV+arozVD+hzWfvsskpxqWYLlaqxYUZmGI0QVIzG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaKgyIT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E526FC4CEEE;
	Mon,  5 May 2025 23:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487205;
	bh=MNGlNLSARosDWL9/qPbCvoRohfJjlFuxy37g7ldF6l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CaKgyIT0JQ3BYtBoBqtJCPVclwQzkS+MCQYQ/P6xt0h4vAVe5cMuh3fONISINAYRo
	 bncPNKdQsPkip4iwrNPuVyLo6bT/kaj8yCKXVLI9xHPBXdR9eXwo7sJ/YyH/wDNe87
	 Zju3wuNXrxJT5J3ZM+hFyFpRd1l11glxEo87HhVPDXbYCAVMjmuvkur+3Z3zd6BJSS
	 mrHsS20X8HlAvwDrfGzDq0mQfWNEldxGEryRKy2v3s1b83LES49GmFnVCWtcAZrsdk
	 1YHinpTqd98DpZmC8pQSavl8ieCVtt6YcHCkbCnJO50Dj4N5h2Lh+mt/uZVcoOumPM
	 +/+NKcF6a96Zw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>,
	Ang Tien Sung <tien.sung.ang@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	mdf@kernel.org,
	hao.wu@intel.com,
	linux-fpga@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 056/114] fpga: altera-cvp: Increase credit timeout
Date: Mon,  5 May 2025 19:17:19 -0400
Message-Id: <20250505231817.2697367-56-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>

[ Upstream commit 0f05886a40fdc55016ba4d9ae0a9c41f8312f15b ]

Increase the timeout for SDM (Secure device manager) data credits from
20ms to 40ms. Internal stress tests running at 500 loops failed with the
current timeout of 20ms. At the start of a FPGA configuration, the CVP
host driver reads the transmit credits from SDM. It then sends bitstream
FPGA data to SDM based on the total credits. Each credit allows the
CVP host driver to send 4kBytes of data. There are situations whereby,
the SDM did not respond in time during testing.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
Signed-off-by: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/20250212221249.2715929-1-tien.sung.ang@intel.com
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/altera-cvp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 4e0edb60bfba6..d107ad73a188c 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -52,7 +52,7 @@
 /* V2 Defines */
 #define VSE_CVP_TX_CREDITS		0x49	/* 8bit */
 
-#define V2_CREDIT_TIMEOUT_US		20000
+#define V2_CREDIT_TIMEOUT_US		40000
 #define V2_CHECK_CREDIT_US		10
 #define V2_POLL_TIMEOUT_US		1000000
 #define V2_USER_TIMEOUT_US		500000
-- 
2.39.5


