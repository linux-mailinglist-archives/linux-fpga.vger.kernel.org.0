Return-Path: <linux-fpga+bounces-548-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39D3910360
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 13:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A1428199D
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 11:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A081ABCCB;
	Thu, 20 Jun 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="H0He8Aox"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64283CF6A
	for <linux-fpga@vger.kernel.org>; Thu, 20 Jun 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884231; cv=none; b=rzfYoNqk8jaBdfr2AtRRKsqpH1G+kvgkdibsoIqlCO8BydO5AISZ5pOYtk7DLtZvyGrJmzvJ3zT4kH+RffM73WvV6WzAVdyUJwN1GyIpCKKQYki4241Oiqs6HbTLpmvq4PIheUBwZYOtLPKyLTH7GNn2v26nTvK4AA/WosqhRjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884231; c=relaxed/simple;
	bh=tZ29Bp2f8Ym6sgD8EffVFer8WDZrFv+PN8PF82wJutE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfII4/OpDZEH2z8n6aT2tBv56U4/d1J8VYaHwSnmqYrY3RHmeH+26m2tN+MJoVJ5whlgD+ZVQh+e86MGA+0IhG5FDLcIFLuiCr4wNQZmAZLx24Tfv355mDR4ZLh+MTjUjyue8YbkMFJgynL/n5FH0BE+aUTNqtjlbnEtnvhG6G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=H0He8Aox; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=jRp699soNP3K8A
	3f8TIcQqsWYfIKLLW0r/ERAheWeyM=; b=H0He8Aox06YFOfIxHqpNP5PUEmF9HU
	r753vMp8hieKLDYEcXrq7yI3ff8JyjWls0qEVGy6mk2aIoF/HsGeY2LN1ft0y87W
	i6EbEnODgkEopUqSN+bJ3KzYrY9fzqif59ajzXFGY/oTayYdmFKmHMmdzsvAs329
	+4mSYkjTyVvHZGuMYiqUQkXSzstxXDWx6fFWyEvDJZHoahFOguRkkAVvWaltdWSz
	AgbsTzFMzgSztDuYhAIj4utSx/AUYK8RJjRoK6HKadlHUfX3/ot+h2/0Ehjc06Dc
	a1yXoIT5Qdx8HdG5IehsCSzm5Tsbnyk9WJa+4EzBVdbav72WLD6OexDg==
Received: (qmail 1002751 invoked from network); 20 Jun 2024 13:50:24 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2024 13:50:24 +0200
X-UD-Smtp-Session: l3s3148p1@n6uQ61AbwpMgAwDPXzjQABqqX1QYyOSW
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2 0/2] fpga: use 'time_left' instead of 'timeout' with wait_*() functions
Date: Thu, 20 Jun 2024 13:50:20 +0200
Message-ID: <20240620115022.24409-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_*() functions causing patterns like:

        timeout = wait_for_completion_timeout(...)
        if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
obvious and self explaining.

This is part of a tree-wide series. The rest of the patches can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/time_left

Because these patches are generated, I audit them before sending. This is why I
will send series step by step. Build bot is happy with these patches, though.
No functional changes intended.

Changes since v1 are stated per patch. Summary: I addressed review
comments and added acks.


Wolfram Sang (2):
  fpga: socfpga: use 'time_left' variable with wait_for_completion*()
  fpga: zynq-fpga: use 'time_left' variable with
    wait_for_completion_timeout()

 drivers/fpga/socfpga.c   | 7 ++++---
 drivers/fpga/zynq-fpga.c | 8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.43.0


