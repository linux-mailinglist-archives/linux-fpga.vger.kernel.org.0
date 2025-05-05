Return-Path: <linux-fpga+bounces-1194-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE93AAB775
	for <lists+linux-fpga@lfdr.de>; Tue,  6 May 2025 08:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056124E2C2D
	for <lists+linux-fpga@lfdr.de>; Tue,  6 May 2025 06:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646723A4FD9;
	Tue,  6 May 2025 00:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F02yCfX5"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A32F47B4;
	Mon,  5 May 2025 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486956; cv=none; b=Oy92w5R+8T9osSjxYzG/Ilio6WtvZBkyOtIdEXG6vJwQhqIjmAiEKHBI213P0K+mfc9utfV2zu0h4wyVrjHmTk64ZubnxGRR6506lmSFcmbyn5KOYG7cP9nJ7OwVkff61ea9XQDaC55TXbHp6zvIjXfFwk8SmqngmK4Dr1jD3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486956; c=relaxed/simple;
	bh=/+aGD+5R3Vy0mhYFWIR+sj/H8L/mSKMlCfXmIIdwlVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=czKNB5BSA2CSiwBu+IkkVIV/0/EAO7EnJZFwNbBmD8AZl5BJ0IiaCs9cc8Ju1LuRRcQlE56jQd2vO8XZq3n6Hd6c/J1WY2sXIk+UhwAeB/lmA7Nej0YkvcGeQZVRSfiU6Ww7i3ThFFK972LX39+0QjWVFACprsVLN0/TxUw9KYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F02yCfX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33049C4CEF1;
	Mon,  5 May 2025 23:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486956;
	bh=/+aGD+5R3Vy0mhYFWIR+sj/H8L/mSKMlCfXmIIdwlVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F02yCfX5mtPkwQ1NjNqcJT/Ew3+LdWd5jm3//ZQtPdDP/WaOOX2NFmmTuS9ITlojW
	 wD8bCXMSP36kjARCJGLRiJqAViTIFdmzBt6IK+y3fPELXtJdzwbolf4QA/gZnRAyFz
	 iK4iOTqweTVJMSLyys+CS/OIJTXxVYWnLp2nkK/DNy97bM627+NCDa8mgy3BzaWufG
	 AeUoC+TIqaapd2X/F6LPtbEh3MaNqu758B5Yw0Rii0xk341WirHyWnMdK2kGx2fVbM
	 rRLmijuXNcH4fCjt2qXkOf5QgfqPKb+brz/h3QlcDGFsGMHKDCwpbALagUYzm6qn0B
	 g6ZhEyh7/6kiw==
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
Subject: [PATCH AUTOSEL 5.15 078/153] fpga: altera-cvp: Increase credit timeout
Date: Mon,  5 May 2025 19:12:05 -0400
Message-Id: <20250505231320.2695319-78-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index ccf4546eff297..34254911c01b1 100644
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


