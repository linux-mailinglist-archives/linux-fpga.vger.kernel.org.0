Return-Path: <linux-fpga+bounces-1189-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C36AAA426
	for <lists+linux-fpga@lfdr.de>; Tue,  6 May 2025 01:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0845161266
	for <lists+linux-fpga@lfdr.de>; Mon,  5 May 2025 23:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A132FC2AF;
	Mon,  5 May 2025 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4dYW9tM"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9495E2FC2AA;
	Mon,  5 May 2025 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483954; cv=none; b=qVHxGPX78Zped+o7wxtmZu1Aywh21SmvrNR9WYzw/PKuTd12VPLEAz8nC6900eGwjz6i6ByUkQhKXiuXoIaWp7dgfUfDrgqmToUd07P8+Yo/30x44Y0B6HJTD23wjmwS8X5M6l9AZeVAAk7oQUmc9Ew7pd2fVMCcjWb+RFVaeyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483954; c=relaxed/simple;
	bh=W2Cu9hRPMdSBIn6W4sF6wD4Okx7o3185REUr24RV8oA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ThhFvcIgYlf/RF0493GPTwlTLP5XhBgceW4lBdqwAjQ/MKh5PFBEUqjB7klyoOj80TRcNSd87KErnsG0o2qpSxbEcVcMKPJgMrXV6ohTqWpl+JFlIXYXfU2Q6RLS9jsmtfpRL+2/Nol+Db5Er2CzagvF1NKFY5Ct7YUvNLk3gdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4dYW9tM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65449C4CEEF;
	Mon,  5 May 2025 22:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483954;
	bh=W2Cu9hRPMdSBIn6W4sF6wD4Okx7o3185REUr24RV8oA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B4dYW9tMP1Rqq2XnqgBEmnR2bTgfYk7TTpzKGYtYqHzFt+O61GXIUD7+dfTwzR6oT
	 lcBS6nBkPb63iDrz3RR2yyM2ofpNkF4dDXswSz0aZHBEVIOqQS+cSg4kRDUiBqXDFq
	 GyxGJgNCsTFzzvpp7kMeoMHCUBS+F5sdHMebuKlXhnFk/N+FZpwAL/C6LQSuYjd1N7
	 BnHaFAJJB16O0ARAuiU5FTGJyBykmfe7VgyMrfVau7S/LFDAoHoMEpTx1w6uAyML/E
	 JNGRnqWAYx8f+w0Ia7TweciuhFG1O/o7Bo+BF9A8h3O8sc6NNwgocXpk9+h/dSErcr
	 7P+zI9xJMzp6w==
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
Subject: [PATCH AUTOSEL 6.14 288/642] fpga: altera-cvp: Increase credit timeout
Date: Mon,  5 May 2025 18:08:24 -0400
Message-Id: <20250505221419.2672473-288-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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


