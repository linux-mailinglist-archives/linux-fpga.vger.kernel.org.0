Return-Path: <linux-fpga+bounces-1191-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42364AAAAEB
	for <lists+linux-fpga@lfdr.de>; Tue,  6 May 2025 03:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B374F1882CE9
	for <lists+linux-fpga@lfdr.de>; Tue,  6 May 2025 01:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864EF2F10B5;
	Mon,  5 May 2025 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD0hGEZm"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD738AC68;
	Mon,  5 May 2025 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486067; cv=none; b=KdJ3/wuiwhhTpdHxRf70N0Ct+WmmPpDmeW4hY3alyD9ndu4PCP4ofS9LOK1TsAOkcEi8m7POmy2uBevycpAnBrKHIn87M4poX21T4LE9s1EROW6c77szw2mXWp6ztkB2MPa6WLCpZ5WNW80q64Jawco/6CNqq6nnlzyTeNnMSrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486067; c=relaxed/simple;
	bh=8NVCDiz8iITfIRqltj6+2O2/8Z/wjMt5J+O98JIyMaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=roz/ZGyO0gb3gKH7hHHvN9YSIXttu23IntZWedCBIZzSOBskFk7n0ptqdhYaroYgKsns0jj/p9hQiXkp5v+qLoJ0F11L3XROMylNPVMLOnUaJLy/VElar53Sp9auDL1h9lcY99L5atR0AdbdhH7KywwwdSqyh+ZvHu3fKLHcXCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD0hGEZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FB0C4CEEF;
	Mon,  5 May 2025 23:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486064;
	bh=8NVCDiz8iITfIRqltj6+2O2/8Z/wjMt5J+O98JIyMaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YD0hGEZmkaLSHuDdUq6WxMnhqXD8zmb6g8Yr9ZGSJxKsSUri6iogYbRx2mu6wyUyA
	 Ed8a7a1PxSOWe7NjLdQGNZLiWjzMbj/x7YVZSZKCmUyHLASM1AO3tHLLBFsp2OPgoa
	 1ugUoPVw05JBIHmH2GEZLbICiu3TGhpcYlLE5U3hD5xwliiDHNqWUbZbLq8WJOPMaK
	 /uD94OLAWgMimZ36SyDOKGDJINqc8YPYNyXFVwhBzjbO2R7FOEIh6LPd/D1kN+nqZX
	 47V8o1lFAb+1nhsPRn6Wg4YkOdpnGJGg6L2a9rnjmvS0tlquvEoqcQFqtUIT6RiMqk
	 kjZgm4CkJaKmA==
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
Subject: [PATCH AUTOSEL 6.6 135/294] fpga: altera-cvp: Increase credit timeout
Date: Mon,  5 May 2025 18:53:55 -0400
Message-Id: <20250505225634.2688578-135-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 4ffb9da537d82..5295ff90482bc 100644
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


