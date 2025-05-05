Return-Path: <linux-fpga+bounces-1190-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B80AAAE77
	for <lists+linux-fpga@lfdr.de>; Tue,  6 May 2025 04:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182733AD8A6
	for <lists+linux-fpga@lfdr.de>; Tue,  6 May 2025 02:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B43F2DF545;
	Mon,  5 May 2025 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpCDwPiw"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E112D37E0;
	Mon,  5 May 2025 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485238; cv=none; b=uX+aa0ZZ0Gf0MFTD9wswWihKVZNz8dpJr+NZoka+bWl9daJJcrk8A+iojzFmolN8g+3VGklzIzJt7aOGf4/b1tS0MvAl4KUxGxZzcskTi1Xj9fIIl5c713uOzEwEVvfKkysBRsFLuIxXuAcdL/0V1SmRjyjXxsCgCmjaNLweFjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485238; c=relaxed/simple;
	bh=W2Cu9hRPMdSBIn6W4sF6wD4Okx7o3185REUr24RV8oA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=onma56KbCoHCoeOepMlBNfAoH5s4FfOo3g0wJkj4SiWIMqvAj5v7ckNY7yo+h6oImLoSvtWaKBTeVr7eN5oDDVmYb6fL3tXIqOKq7uv4sN8qNmAtMl/k/NO/vvfBUZac6X/oPjvHZ7uxsxMGne85Q1KGfC6H/2BKFbywONcMztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpCDwPiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FC8C4CEEE;
	Mon,  5 May 2025 22:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485237;
	bh=W2Cu9hRPMdSBIn6W4sF6wD4Okx7o3185REUr24RV8oA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GpCDwPiwxTtGTUwb42wyS/vKWErLnuDdGkgpKxFpfar+CbAePDMJnc8hUFK9G0jLw
	 7hvuxUztVfJGp6ePL282wjvsvoxXnuG0v0TE/+enc5jjrBrH2vhBFSLvQmIyA06QlF
	 RRPHIOw+unlJtDVFAm60mjgocZ9ZD+Evc0jxqTfJ/+T2ZMudXyMquGZAcOSA4/LqJs
	 yTOBwTC/0I/k3QGnwkqiEChs25RR7rzHXqrhfX+GXrfh7gJzGkR7W7iUs/gjmyWT4w
	 OCV2cyP5t7YEBhl07frcnuDu5b1viuQNMFTf4OA4qzgjH0tmCrcsyjOeh/mQHCNqZm
	 xxD59xr4wKZfQ==
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
Subject: [PATCH AUTOSEL 6.12 227/486] fpga: altera-cvp: Increase credit timeout
Date: Mon,  5 May 2025 18:35:03 -0400
Message-Id: <20250505223922.2682012-227-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 6b09144324453..5af0bd33890c0 100644
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


