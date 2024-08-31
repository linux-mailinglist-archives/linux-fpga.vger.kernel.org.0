Return-Path: <linux-fpga+bounces-699-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E5E967289
	for <lists+linux-fpga@lfdr.de>; Sat, 31 Aug 2024 17:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5FC1C21206
	for <lists+linux-fpga@lfdr.de>; Sat, 31 Aug 2024 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75602C87C;
	Sat, 31 Aug 2024 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6J5rkXJ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364FB15E81
	for <linux-fpga@vger.kernel.org>; Sat, 31 Aug 2024 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725119705; cv=none; b=CP2zeJVePKWvt98C7RGK2zarVSa2/UTj2kFhdtl9JLv8CFDpAfmmt8yxXFVbLPRAkNx4lVFlvfboVfvGSN+S0mp38EeTTjp6VXgPTl52a2xvXxGiLIddOtKrXtRqXUrsaiM73VNfuLBk2aJumJAP+HHo388sRsm4M97IGYRbFJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725119705; c=relaxed/simple;
	bh=7fKPyMxGp1mpC8Nsx+y3p1FBdueKS1o6VuV/bScPa2E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jJEl5IYBMCQaDD+2UthatjuKQBg0EzANybGd3LWUbzMyELjv6miA4xwmX5w/6eRbSfoLOxswMRZvvjf0p9dLwHT3pAItw50p4P/fwQjfWRqXfEbapv7zUGm42qOsLInKQQ7rHNci4gZxKGQZKTWRNWBtE/6U/7UQaiOuoKKHo3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6J5rkXJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725119704; x=1756655704;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7fKPyMxGp1mpC8Nsx+y3p1FBdueKS1o6VuV/bScPa2E=;
  b=g6J5rkXJXTSC+c5Gm5CrhCq1LzOrukzitW0hYUXeA61YTS88n6Pcv/PT
   h5QTEHGK/JpKbie1JQubczTTxGcc3ouC0B06H1GAGuPTXuI9VFQDoyCYJ
   e6e4+z82kaFucK0EOxPdFMqcvKxAfuIAVM6ILkxbybudGXYHTE7cexWba
   8R/Ou6gb1ZOM0oYbPtMoR8OyPtwKqbPJYa7QfJinc/NYAvqIFGNgK+R3y
   NbkcWCs7g5t0cg2mkZvoJzcAvOqCOM3GvwsDahBxoe4Flb+ygS2UOhu3I
   hIU916iAFwmt/as9hHVT6AmT9Wc/cVhly5eNWLghXjs3fTR9hTuTX41v+
   A==;
X-CSE-ConnectionGUID: WisOrS0/Qvq500lLPNWz+w==
X-CSE-MsgGUID: 6S+L4he6QquQ/raWpnBvXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="41244379"
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="41244379"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 08:55:03 -0700
X-CSE-ConnectionGUID: iYuE5XccSQuSoeKBbT8qBg==
X-CSE-MsgGUID: Y3QatwAATjGS733BI019kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="64133881"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 31 Aug 2024 08:55:02 -0700
Date: Sat, 31 Aug 2024 23:52:33 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.12-rc1
Message-ID: <ZtM8QWGFKIRLc+NZ@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.12-rc1

for you to fetch changes up to 8de36789bd038ae24e29c40cbbc9e7d59604f54f:

  fpga: zynq-fpga: Rename 'timeout' variable as 'time_left' (2024-08-14 23:58:14 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.12-rc1

FPGA unit test:

- Macro's change improves fpga tests using deferred actions

FPGA vendor drivers:

- Wolfram's change renames confusing variables for Altera & Xilinx
  drivers.

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Marco Pagani (3):
      fpga: Simplify and improve fpga mgr test using deferred actions
      fpga: Simplify and improve fpga bridge test using deferred actions
      fpga: Simplify and improve fpga region test using deferred actions

Wolfram Sang (2):
      fpga: socfpga: Rename 'timeout' variable as 'time_left'
      fpga: zynq-fpga: Rename 'timeout' variable as 'time_left'

 drivers/fpga/socfpga.c                |  7 +++---
 drivers/fpga/tests/fpga-bridge-test.c | 25 ++++++++++-----------
 drivers/fpga/tests/fpga-mgr-test.c    | 28 ++++++++++++++----------
 drivers/fpga/tests/fpga-region-test.c | 41 ++++++++++++++++++++---------------
 drivers/fpga/zynq-fpga.c              |  8 +++----
 5 files changed, 60 insertions(+), 49 deletions(-)

