Return-Path: <linux-fpga+bounces-1296-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CC8B1C120
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Aug 2025 09:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D2B18459B
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Aug 2025 07:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553CD18871F;
	Wed,  6 Aug 2025 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/L5obQN"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD660171C9
	for <linux-fpga@vger.kernel.org>; Wed,  6 Aug 2025 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464549; cv=none; b=h1782mH0TllOhXu3FS14QQ1fr7nT2lpaDUGlyKXNuB/pIl8c3y+yx7BOlz/9pQhNUfbLRmMtM2mC6OFCpKF6rLQIT9uII2AsNxNIL6OXZGMsdiq7fiUuxYscOTRA755neY0fAi5bKWJMMuZM+EOCw9qpjRWo/DaZ97p32JJYLf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464549; c=relaxed/simple;
	bh=3LlAjCtwvEy8HUu6B2du/dTXuQPV1LMfZWaQL98C94s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qu+9uY1BC35u0oVX5vMIuBMT5V8ZH1aJkf+L3U6gsDvtCPw4r/mvJeGvo2hJ5f6yn+Qx/hwlcFZmbnwpbjS6PCL8qmyc4eJYPzwwgmcnIWXF/AJujYhwdM/fh1rrQ/f6g6RGTGVWckq7KqjakcbI93dG8NZyW/QD68hUO6x22+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/L5obQN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754464547; x=1786000547;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3LlAjCtwvEy8HUu6B2du/dTXuQPV1LMfZWaQL98C94s=;
  b=n/L5obQNG1XPbQdom0fTCy1NXc8lf0/3jsuCEy+NJ2LN+ct2WA2u2HPA
   7XHNo4rcHKLqIhp3VzuNwnur3O5QpGn1OaGT+6bEuAYVc8oMkuf6ojwv5
   Q/wopXkTgGmZ6n+eT1rsuaZuZS5ovVBTaghQNHkzTlz/OwMGY73WJjiLg
   VK7y+c8pNMn5K1oPFC4FbJHBJGe+6sJNAtZkSH6TnS98948gSY/N5H6WD
   GABlJmnCJ/KqVeeXxPX/yL3T2Tceur/6rd50qXUAt/NEvcd8WNhHnQTGF
   YdEQxZcMAnFtdJ7KsurtpWP5dwtblrlicc98O3oVlU3/yQC3V26syyiBL
   g==;
X-CSE-ConnectionGUID: 1FhDyDOAQ/evR10gqHs8MQ==
X-CSE-MsgGUID: V5AkZvNXTum1TMQbBMYbpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="68147558"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="68147558"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 00:15:47 -0700
X-CSE-ConnectionGUID: gFZpGVF1TfiORxGe4XfFqA==
X-CSE-MsgGUID: sg4WcpDaTNellfS7XAQPkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="163952239"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 06 Aug 2025 00:15:45 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: jgg@nvidia.com,
	m.szyprowski@samsung.com,
	pisa@fel.cvut.cz,
	yilun.xu@intel.com,
	linux-fpga@vger.kernel.org,
	mdf@kernel.org
Subject: [PATCH 0/1] Last minute FPGA fix for v6.17-rc1
Date: Wed,  6 Aug 2025 15:06:04 +0800
Message-Id: <20250806070605.1920909-1-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg:

Pavel found the patch (already in your repo) for v6.17-rc1

  37e00703228a ("zynq_fpga: use sgtable-based scatterlist wrappers")

breaks Xilinux FPGA driver. Here is the fix and I just pushed it in
for-next.

Since it is now rc7, not sure how to address the failure:

 1. revert the original patch 37e00703228a
 2. quick apply this fix
 3. merge this fix into 37e00703228a

Xu Yilun (1):
  fpga: zynq_fpga: Fix the wrong usage of dma_map_sgtable()

 drivers/fpga/zynq-fpga.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1


