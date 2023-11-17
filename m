Return-Path: <linux-fpga+bounces-8-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A007EEDAC
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Nov 2023 09:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40991F24E09
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Nov 2023 08:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA3A6AC2;
	Fri, 17 Nov 2023 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmVawmQW"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08529196;
	Fri, 17 Nov 2023 00:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700210542; x=1731746542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EEkIXmHOKSdswOgaeNVurkzd4xWtTvPVbwH173FnRxI=;
  b=JmVawmQWwkubjkpFPPt21FapUn4Oib0i7Uat9NWO/eEdGdTGXHClYWXt
   ZIj/2AeyNGresgaC/QOTu0JjBBsXtpfXIa7o5JptbPtnEJXCGgBlonzeH
   v1lRPtyvqtkw3su9uqBVQN0VJXLdTtdcuoFI0R7NOR99Ej/TVhn9wUFZG
   e9SJM6XcvCKU/9XYLtnXMS+5SvekBt7AELWF/dxzvmL7io8JOCCN6Ioo6
   Wb8GfmhHHWG61k/bUGgrNBgdaRGCI3sHzeNeGk20zERrIHA08nzqiM0Em
   yzVOqzaMJhf8lTgiONbairYJ607gVGqv7jFFXhshzs5d+h2bxG/bwttZm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="390116125"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="390116125"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 00:42:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="883059947"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="883059947"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 17 Nov 2023 00:42:19 -0800
Date: Fri, 17 Nov 2023 16:40:33 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH v2] drivers/fpga: use standard array-copy function
Message-ID: <ZVcnAa246LUOhlG0@yilunxu-OptiPlex-7050>
References: <20231114111901.19380-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114111901.19380-2-pstanner@redhat.com>

On Tue, Nov 14, 2023 at 12:19:02PM +0100, Philipp Stanner wrote:
> dfl.c utilizes memdup_user() and array_size() to copy a userspace array.
> array_size() will likely never trigger thanks to the preceeding check.


checkpatch says:

  WARNING: 'preceeding' may be misspelled - perhaps 'preceding'?
  #7:
  array_size() will likely never trigger thanks to the preceeding check.
                                                     ^^^^^^^^^^

I fixed it myself.

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

Thanks.

