Return-Path: <linux-fpga+bounces-1199-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48247AB2990
	for <lists+linux-fpga@lfdr.de>; Sun, 11 May 2025 18:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98133188F3CF
	for <lists+linux-fpga@lfdr.de>; Sun, 11 May 2025 16:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E9B19CC1C;
	Sun, 11 May 2025 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsKqHAch"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B96E155A4E
	for <linux-fpga@vger.kernel.org>; Sun, 11 May 2025 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746981146; cv=none; b=BSVWfzyWHkeVJjTA29/GbZZPF7TmYjHTvidCxOqWnfIHXIm/s8xbPMqo5nMwPuSJ0vO/zR5SYw7VdhYwnpUM4kkrjpM+ve4cDMKZGix17lEm6qMQkJPHJvV1ApfbL7lYF+FZ7lkfCd6rUxEqgBg69gv2+3/55hBEDdc514Yc/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746981146; c=relaxed/simple;
	bh=bLCZVrVjwof50PePUS2M3EzMyP4g43mpNsTQUEsSI6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qSm8QRZkIiB80DcxDJy9hPyGHKgSTldvBxBQozWD35I3DeYaTOPz7T17V2k07yRmf/l6JDOYeQ/Qr4oekJz+DUKah9zileGcYA0Aa9E7eDVaO0/nchgeAiDIKAV6of33F0cY0u3BclfOq6gFm6PrHbY79pbQP91G6tKi64g4v6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsKqHAch; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746981144; x=1778517144;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bLCZVrVjwof50PePUS2M3EzMyP4g43mpNsTQUEsSI6Q=;
  b=VsKqHAchGhvOD2u54ylA6/5tad0UXwUIlgdBWrtyQvuqJ8aQe073j9Gd
   7W1DHMjjVLLFcbbMzeT7h4oKXdCSeD/S45yi7qhomhHW0pXIMHH8tSF7k
   VavPsj0DgcpTVlwUXfeoEp0Gf2qZPfxGCIXbDjp+1t1NlomIMfB3XJeRS
   66eL41Pbriht+R3yZCYl98Y0YrSQ9rtNkjvDJ8FBo3nbxHRTKRAwgLyFt
   a6MekYQXdH4uILfwb45TTiNkevRf8X8Savok4M5m7e4Enf2ej6TmiEM7L
   4OeaCBE5yhIhLoDexuD5WFydWZ42rcFiU9aNT5cvdThfyOmGVtuHh8hm2
   A==;
X-CSE-ConnectionGUID: nMmxgKQ7QuC7CNnv/qeW5g==
X-CSE-MsgGUID: P0QL0hFHS5ypnFvn62abEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="48941446"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="48941446"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:32:24 -0700
X-CSE-ConnectionGUID: /enaJx/FS9KpOUFJPwB70g==
X-CSE-MsgGUID: R9UJuhBcS+ymdSFGb29c0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="141198818"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 11 May 2025 09:32:21 -0700
Date: Mon, 12 May 2025 00:26:55 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.16-rc1
Message-ID: <aCDPz42LmQ47ANDX@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.16-rc1

for you to fetch changes up to 6ebf1982038af12f3588417e4fd0417d2551da28:

  fpga: fix potential null pointer deref in fpga_mgr_test_img_load_sgt() (2025-05-06 00:37:00 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.16-rc1

- Peter hands over the maintain role of m10bmc-sec driver to Matthew.
- Qasim's change fix potential NULL pointer for fpga test.

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Peter Colberg (1):
      fpga: m10bmc-sec: change contact for secure update driver

Qasim Ijaz (1):
      fpga: fix potential null pointer deref in fpga_mgr_test_img_load_sgt()

 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc       |  4 ++--
 .../ABI/testing/sysfs-driver-intel-m10-bmc-sec-update      | 14 +++++++-------
 MAINTAINERS                                                |  2 +-
 drivers/fpga/tests/fpga-mgr-test.c                         |  1 +
 4 files changed, 11 insertions(+), 10 deletions(-)

