Return-Path: <linux-fpga+bounces-1175-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAD5A9BD9F
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Apr 2025 06:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04581BA35BB
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Apr 2025 04:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA25217F53;
	Fri, 25 Apr 2025 04:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nC0h+B7S"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B4134CF;
	Fri, 25 Apr 2025 04:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745555559; cv=none; b=mwL1l0330CnWy3QSI1XALrKRh44BPXFZIVvmXJJYEurtZIFY/bL5pKwzvPYcB60Gf6x+mQq7pZl/sMFrVKq+wIOMxyZkwayeIVGtCGAoJotgFBdjzXzg08l49725nOB3UbPMox2Y3cXg/CDE/9h8q1mnc0vCllZNrQvqfgkQAQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745555559; c=relaxed/simple;
	bh=jwon6my1/h7fyJvMoj0jyEwXJg1ZkBYWbj5V0De48Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MV/C6Wdjg3l87GRUxFczOkPnD9EtfZSPtd1S0+k38nzSmgq4Bubt0/dgxfN7jbzoDnNzjObKWXnOlNp8wnBW6VpaFSUj6X0xaNKziyxgXB0OAF/y7LtlTTcIpC2TmksH/eOthO+lGV7hD4oZ45W9zKqpGkCvTNF/671prxEKeI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nC0h+B7S; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745555558; x=1777091558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jwon6my1/h7fyJvMoj0jyEwXJg1ZkBYWbj5V0De48Zo=;
  b=nC0h+B7S1ZFaA4L04SNWVXkNRoQ3san/l86l9Y9WG8LOpvt7upb7X+lT
   LOF83+sCN0BujkxiIBsr6CRBgp9yemO1EsoluLTG/5GQReXA3c44WmX9Q
   fpZSdRvsZXzwrjvBnnWIme5nmBM0VpSUNYn1k6V/Vnr7RMgYlvRmjfWtI
   6rjIrv/hfZskAgvH++WijTy6l2zPPwl/zBnt2mCswP/Gz3yxbImolf866
   7CWbKd+f9bd8HPdKxeJ+VWxlLy+PVJ+QUsF8HpBczRdaaHGvKmpuN3R7J
   Yf6JP6iujP5uI5A60GoFlrqoEmf4LbN+7edNcRo2FCZq2/ye4FnEn490h
   w==;
X-CSE-ConnectionGUID: OOfVveH7RpGBRwbCpOdEkw==
X-CSE-MsgGUID: ULQEkWH4QIWQMPPKyUgvlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="34830385"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="34830385"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 21:32:37 -0700
X-CSE-ConnectionGUID: ajgVh2KbRfetbXQBXDRp3w==
X-CSE-MsgGUID: fZVX4imIQrejq1t+17KEVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="132689040"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 24 Apr 2025 21:32:33 -0700
Date: Fri, 25 Apr 2025 12:27:56 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marco.pagani@linux.dev>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
	Marco Pagani <marpagan@redhat.com>,
	Russ Weight <russ.weight@linux.dev>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] fpga: tests: add module descriptions
Message-ID: <aAsPTN4y2nf9q+ht@yilunxu-OptiPlex-7050>
References: <20250324173242.1501003-1-arnd@kernel.org>
 <20250324173242.1501003-4-arnd@kernel.org>
 <6ab8b951-a2be-4434-8621-0b31d00608ad@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab8b951-a2be-4434-8621-0b31d00608ad@linux.dev>

On Tue, Mar 25, 2025 at 06:06:51PM +0100, Marco Pagani wrote:
> 
> On 2025-03-24 18:32, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Modules without a description now cause a warning:
> > 
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-bridge-test.o
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-mgr-test.o
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-region-test.o
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Marco Pagani <marco.pagani@linux.dev>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

