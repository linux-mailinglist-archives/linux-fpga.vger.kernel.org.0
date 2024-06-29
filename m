Return-Path: <linux-fpga+bounces-569-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CA291CB5C
	for <lists+linux-fpga@lfdr.de>; Sat, 29 Jun 2024 08:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C905B284462
	for <lists+linux-fpga@lfdr.de>; Sat, 29 Jun 2024 06:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB9524B26;
	Sat, 29 Jun 2024 06:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNwnCZ04"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D63C36
	for <linux-fpga@vger.kernel.org>; Sat, 29 Jun 2024 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719641808; cv=none; b=AU3W8aXNcWOdIZ190OrClO+qGtf5Nj71xOhYzTfNqR4g40LEpAf1FU5ugiGoi0Us63EYMq4J5KOW2L/cwF70CyyoikiB5M1AgIHtVFFwG5519H/lyJYerOMnrkp9YTBei8iT5Uqsl1TZnFPZ4SbdouJJQ0fK6FS5yTZplReEeHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719641808; c=relaxed/simple;
	bh=bfxKTRLpyFBq+92BjcJqmM28meRWtxPUhFKOgWPq9kw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GSrnF5akGlZ37wEEIxG0GlDV1xQU9f9W6P19m2L0YKNFphssA5iH+PalkHbQ4gbQFQ+/Sq5EFbzds4F794IPQbuAej4DXzudT0gQWPKISmzVjQk2liZibuJsbnq8J4ipWE9AE8S8t45x7XYlXHC01MhJ33L/pdXN67Cmv0J+oIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNwnCZ04; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719641807; x=1751177807;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bfxKTRLpyFBq+92BjcJqmM28meRWtxPUhFKOgWPq9kw=;
  b=WNwnCZ04rTHkkosK1e5kwvqyMYMgbu373ZmU7M57XIgDjnp8xmdKozjG
   6iD2VJnuD+GcFl2mXQQtot+bDWuLfT1nOS9ZO0dmFq3sHyLPbavxlEUzX
   jSbBIz4FTHWZfCIYnvgbjtiQePlU4bCd/3M88gpQa5vCtOZCm3AVKBYdO
   IM9oG6f9lEZRD2cpHfv5BWOLPAsVEGFxNxAjtC/IgNk1xtlVJqIQdFecL
   sKyVg48rNYpEtH/TWRoxD9iNkQMH55K7yHHBlyhBhfx/o1ZD3rlYWI++8
   uVH5mokCQUqT17oL/2MhkCUIwIYSnQUyENb25c/SlQGIwh4RYvMIW/vLl
   Q==;
X-CSE-ConnectionGUID: u2ZB7XxJQpWX7o6FQDE5BQ==
X-CSE-MsgGUID: jNugSbluQjaSt/OCCzpihw==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16971428"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16971428"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 23:16:47 -0700
X-CSE-ConnectionGUID: oxOWK3HCQnWsCt7tqIY55w==
X-CSE-MsgGUID: VDrQfFEeTE+P+dvMD+zkfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="44858168"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 28 Jun 2024 23:16:44 -0700
Date: Sat, 29 Jun 2024 14:09:50 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.11-rc1
Message-ID: <Zn+lLiSHzlysDRbI@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.11-rc1

for you to fetch changes up to 3a0fa8e97d3024de199634667900b6a90bbe43d0:

  fpga: altera-fpga2sdram: remove unused struct 'prop_map' (2024-06-14 10:18:11 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.11-rc1

FPGA unit test:

- Macro's change re-enables FPGA KUnit test suites been configured as
  loadable module.

Altera:

- David's change removes unused structure definition.

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      fpga: altera-fpga2sdram: remove unused struct 'prop_map'

Marco Pagani (1):
      Revert "fpga: disable KUnit test suites when module support is enabled"

 drivers/fpga/altera-fpga2sdram.c | 6 ------
 drivers/fpga/tests/Kconfig       | 4 ++--
 2 files changed, 2 insertions(+), 8 deletions(-)

