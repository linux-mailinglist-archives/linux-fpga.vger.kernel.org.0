Return-Path: <linux-fpga+bounces-55-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3CF816618
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Dec 2023 06:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F47281F45
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Dec 2023 05:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A577A63CD;
	Mon, 18 Dec 2023 05:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6p5DqBy"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492D263C9
	for <linux-fpga@vger.kernel.org>; Mon, 18 Dec 2023 05:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702878252; x=1734414252;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a7/8EaKwhaPtbcBGpCOUYGIJmvuig2wGqYckYgDJR8A=;
  b=O6p5DqByRTBEvqL03LfuBswlfSsOsImUaz1EYE6IPDvcdHm9uADJYVpt
   6MiwP+FZV/IpJaQUMiQYWJ9Vv36aa7Dmfyc74snrFdCwZL+IiN3Y2OkYe
   BCRE/d4C+Vt9XBssyQimG2zy3Sz99dc5tPUv1IQHrVY74hreOS4T/c/Td
   iE697Sr64nO1e7vr4EwNBuSpakEkl2dn91pccYuOYCmJnrh0b1x0HvmJg
   A4Farq6xSg51uOUEpbaVSQS2/uId2J29+T1gncgb6jont/QiCCo0P0QWx
   pLGOZCyYnXs+Bo4G6ouZ8CpKvG9OLY4TVusL9GjxAdWKuVFFNZTlS6O6U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="8903700"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="8903700"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 21:44:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="725185297"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="725185297"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 17 Dec 2023 21:44:09 -0800
Date: Mon, 18 Dec 2023 13:41:41 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.8-rc1
Message-ID: <ZX/blWwXpO3/K914@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.8-rc1

for you to fetch changes up to 5496fb8eedd637e1e9d87655f86dc816afd5ad68:

  drivers/fpga: use standard array-copy function (2023-11-17 16:34:26 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.8-rc1

DFL:

- Philipp's change uses memdup_array_user() to do better overflow check

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Philipp Stanner (1):
      drivers/fpga: use standard array-copy function

 drivers/fpga/dfl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

