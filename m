Return-Path: <linux-fpga+bounces-1193-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB7CAAB706
	for <lists+linux-fpga@lfdr.de>; Tue,  6 May 2025 08:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057A37AB3E7
	for <lists+linux-fpga@lfdr.de>; Tue,  6 May 2025 06:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829C8473DAA;
	Tue,  6 May 2025 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dtpum0PY"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAC43839A1;
	Mon,  5 May 2025 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486593; cv=none; b=AzDnKY1EvHMLZw/rgzx9bVRe73pkG1OnYt4+Rl2JfUo6iX/Kt9omR5ZiXTKi0W0vJEZ1bDPJ8QsTV8eWzO3IfNxlDFKWcydhLGlGjMNyVVgZhPtbA3RsFJJNW07wMIgDR/I+EoB1P6LN9B881DTzDcJ1e5Gvs1+RQ7rjl5NVoww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486593; c=relaxed/simple;
	bh=8NVCDiz8iITfIRqltj6+2O2/8Z/wjMt5J+O98JIyMaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HaHgyyuL+DZC9ecEvpsyibFE0NxeT3RgQsgTap0yPX7jKbfZNDGg/+I9AOk2Um1SDB0ANfLxaMAtQsYqrwuRrnLtKPkvDhOyr4C97WFcIckYjspzzHaEApAba4nTZ/s+hvyK2jafAuF+8ZPkPxXACxVXpxZSDqYPSbLuDhGXVrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dtpum0PY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C41C4CEEE;
	Mon,  5 May 2025 23:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486593;
	bh=8NVCDiz8iITfIRqltj6+2O2/8Z/wjMt5J+O98JIyMaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dtpum0PYtsNzZFmyOEP/ibzMb3vADc/bhziCycdERO9TseylqH5901oOPExfAYgSE
	 9eC3lc7JjISit3irdaF1QXYwYJkOxN0v7TvNmpdfyFLTFLIFtR5sExri3xU+XEwg2P
	 kNegH0SHQM+FYkHygQwkNYH87coa+NIhM8oQG3oKr8celZR7W27egBJMFVF+mttn3l
	 mG/8VLE+X2ks6UjjDtlncYeTVIBHMBJKWrB1tRCQS8TlJ3ERsUsvhTLah+6qa99sH/
	 0nme6ecyDkqCpLFfubZuPTBYlagiMmXGkHzI1mPiNtGt8w1dtJTGOIyYHXX1od/+1r
	 PrTmxgRGA4AnQ==
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
Subject: [PATCH AUTOSEL 6.1 107/212] fpga: altera-cvp: Increase credit timeout
Date: Mon,  5 May 2025 19:04:39 -0400
Message-Id: <20250505230624.2692522-107-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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


