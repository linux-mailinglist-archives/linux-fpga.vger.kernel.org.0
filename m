Return-Path: <linux-fpga+bounces-1418-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A793C35B1E
	for <lists+linux-fpga@lfdr.de>; Wed, 05 Nov 2025 13:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3321897723
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Nov 2025 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FBF315D4F;
	Wed,  5 Nov 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="YF8JrRvg"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp114.iad3b.emailsrvr.com (smtp114.iad3b.emailsrvr.com [146.20.161.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BAD301461
	for <linux-fpga@vger.kernel.org>; Wed,  5 Nov 2025 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346799; cv=none; b=XYTgrnE9JTti0ejMC+sg4OAuJL/T2zL6hS4zEPYey+bfUzfFX7JH+0MkIP//637PxnNYTu/11qfvaJ68gNorp4MF6RP4WgkhlyYmcKvUetPg/9/1KT/1ALcpYTPmzoga4/Jak48vh+VD5xKiYGge/BiLKGa1wnMsU+ji5NX3mSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346799; c=relaxed/simple;
	bh=tbXurC/ZeUDvs37VmRLP0g8kztrxZaxNimK3BpRMzpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsmwzUzOHk0z30hVP4iXzCHVbqyhdjUtK0qQnXv3X4j72pt4a5Lwwbz8USIneRHeuaxNtEPgiF/ePbrKwBLPZhRkwduJqwueWU8fl1IUMog+FfMEYEt7AFRkD0gGBDHhBPI0zx5qOiKY9QIOzx0xECRjBNz9sbGnOV+XsofDedE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=YF8JrRvg; arc=none smtp.client-ip=146.20.161.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1762346282;
	bh=tbXurC/ZeUDvs37VmRLP0g8kztrxZaxNimK3BpRMzpo=;
	h=From:To:Subject:Date:From;
	b=YF8JrRvgdrNN4YQ25AlsWsubFvOneFGb+diz4tH34QBW62pg4L+QcEXhbVQuWPFCR
	 QXYfBHohExT6CfdAaSP7vibXZYuQnTu2LlHvzJeHW3yDdcalkPmSB2UWfp6Jw0IRiH
	 +IWxDCmkSDndQwp2Sd/xx31rPOJnaOJ+RaBYT+Po=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 023CA60333;
	Wed,  5 Nov 2025 07:38:01 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH v2 1/4] fpga: altera-pr-ip: Add dummy definitions of API functions
Date: Wed,  5 Nov 2025 12:31:05 +0000
Message-ID: <20251105123752.93672-2-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105123752.93672-1-abbotti@mev.co.uk>
References: <20251104153013.154463-1-abbotti@mev.co.uk>
 <20251105123752.93672-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 2331ede2-2f65-45fd-b71e-e0d81416256f-2-1

Add a dummy definition of alt_pr_register() for build testing.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: (1) Add missing #endif.
    (2) Correct conditional compilation test for ALTERA_PR_IP_CORE
        tristate configuration.
---
 include/linux/fpga/altera-pr-ip-core.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/fpga/altera-pr-ip-core.h b/include/linux/fpga/altera-pr-ip-core.h
index a6b4c07858cc..f91b4cf918fb 100644
--- a/include/linux/fpga/altera-pr-ip-core.h
+++ b/include/linux/fpga/altera-pr-ip-core.h
@@ -11,7 +11,15 @@
 #ifndef _ALT_PR_IP_CORE_H
 #define _ALT_PR_IP_CORE_H
 #include <linux/io.h>
+#include <asm/errno.h>
 
+#if IS_ENABLED(CONFIG_ALTERA_PR_IP_CORE)
 int alt_pr_register(struct device *dev, void __iomem *reg_base);
+#else
+static inline int alt_pr_register(struct device *dev, void __iomem *reg_base)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 
 #endif /* _ALT_PR_IP_CORE_H */
-- 
2.51.0


