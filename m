Return-Path: <linux-fpga+bounces-1077-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25051A4AA0E
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Mar 2025 10:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A21DD7AA519
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Mar 2025 09:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B92A1C5F22;
	Sat,  1 Mar 2025 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkjJU06V"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A3D23F392;
	Sat,  1 Mar 2025 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740822430; cv=none; b=TA3gfeOCTY4gz0qRab/4S664RleupN8AjE36GW46w/NBHrA/adGKDQAlfQOCKrcZwBa8dZk/uZEfanYv5zTAZ+TUynvrLxSlnq+fukD4pkCxDb5TvXrRzCqAHdbwkIV7eqCmSPmrMdMKtg08NgklNqTxWDlThXIcryl3GbCuBSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740822430; c=relaxed/simple;
	bh=Sm2gXHZ+ErYhwadXO0aUguITnUMXcawfh5SkhdoAdwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOHlhaeVY72i+oDvZs8y+pw9mphtsr2UjzaAOqOEmnBmldc2wT4yiX1tdok2sM5sFKCRjY4oLp13V91X4zGUL4n9ZdfyDRi8AeSkULrXSlu4SWgzFs7o57Jx9kCR9mQJ0EIgl606/dd5k1QQjCED06+AmkJ6rFZbE9hDckQeQgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkjJU06V; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740822426; x=1772358426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sm2gXHZ+ErYhwadXO0aUguITnUMXcawfh5SkhdoAdwI=;
  b=IkjJU06VffUXXivRvY2x4j7LQ1HS2oxXwg+gIVj4IR/phxmOVSXr+CKg
   LDG8MN1kP5Mo/+scRNIN+zfqk4mD5hCHuj7E9nq1pT0kUOPu3fmAYhZM4
   wFBOiJjVLcOCtQptFr6s49WnumRGRt/xwDfOJHc0ETdQsG58utOkRJuT6
   3P86c6J9sDtcQh7AwA/9J52IHACod2fmnRzfgxNzAyLz6945cEFgzl74S
   /rE3WDbbn7mAgULBIBaW57C4rSuCpSOykRK79WtgGPvkzkkwfnN0PEkzM
   NFDaW6dyYFbUYYwldCygNo7XkkZF0r2L6xztZnpdxZM02pYfXcBpnsqZc
   w==;
X-CSE-ConnectionGUID: uQQGr60hStKxlWKq2Lnzww==
X-CSE-MsgGUID: Jq1P0d83Tbi9ybGZNvOvXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41448344"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="41448344"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 01:47:05 -0800
X-CSE-ConnectionGUID: Di+ROpfrRtSGAKWj4K++Nw==
X-CSE-MsgGUID: wFMmdiuoQgyH2F/tTi3rPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148468294"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 01 Mar 2025 01:47:03 -0800
Date: Sat, 1 Mar 2025 17:45:04 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: tien.sung.ang@intel.com
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	kuhanh.murugasen.krishnan@intel.com,
	kuhanh.murugasen.krishnan@altera.com
Subject: Re: [PATCH] fpga: altera-cvp: Increase credit timeout
Message-ID: <Z8LXIOjrnmBTrQKs@yilunxu-OptiPlex-7050>
References: <20250212221249.2715929-1-tien.sung.ang@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212221249.2715929-1-tien.sung.ang@intel.com>

On Thu, Feb 13, 2025 at 06:12:49AM +0800, tien.sung.ang@intel.com wrote:
> From: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>
> 
> Increase the timeout for SDM (Secure device manager) data credits from
> 20ms to 40ms. Internal stress tests running at 500 loops failed with the
> current timeout of 20ms. At the start of a FPGA configuration, the CVP
> host driver reads the transmit credits from SDM. It then sends bitstream
> FPGA data to SDM based on the total credits. Each credit allows the
> CVP host driver to send 4kBytes of data. There are situations whereby,
> the SDM did not respond in time during testing.
> 
> Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
> Signed-off-by: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next

