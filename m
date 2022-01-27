Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544BA49D6F3
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Jan 2022 01:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiA0ArP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 26 Jan 2022 19:47:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:16653 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbiA0ArO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 26 Jan 2022 19:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643244434; x=1674780434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iZRuJb3s1UbgpoZwtSTcan74PsV+EpZbCNeixiDzuJQ=;
  b=YOfsdzNWY82zffBcQAh2zWy3TLbCGt5eKVWqZeX1NeYu3wKYksJ83VCR
   iZLD0U0xUK7+C1EWZmmUpgHNN7EomZJR6skSuTEkus3xJPU6U4FwXupZJ
   iXDQBr8abILCP/QdHCG798ItrrS1EQK1PCzNzms1nfD6zohQ1OtqYGC08
   Brj7N40g3gqLEAqZKkme0CU0vPBly64yMaabrULQM2LST4wsrPx+mXcvo
   s+sfnCK2+LilkkvX8YE1jwcEmrUzMA8AzswiNm4Ycdj/zePWtw3N6Vqv0
   sxYe3UnAe5tft8n5Lz5hJ2VLUoMLgaI4LS0Zs6pbperP4fS7jjN84vaK5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="333059115"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="333059115"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 16:47:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="480090799"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by orsmga006.jf.intel.com with ESMTP; 26 Jan 2022 16:47:12 -0800
Date:   Thu, 27 Jan 2022 08:39:02 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, hao.wu@intel.com,
        trix@redhat.com, linux-fpga@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCH] firmware: stratix10-svc: extend SVC driver to get the
  firmware version
Message-ID: <20220127003902.GA1144478@yilunxu-OptiPlex-7050>
References: <20220125192853.1956486-1-dinguyen@kernel.org>
 <20220126010723.GA1139334@yilunxu-OptiPlex-7050>
 <5a1b6658-062c-d777-69d3-6a053d087ca6@kernel.org>
 <YfDUGD5+hqOnSNjP@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfDUGD5+hqOnSNjP@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jan 25, 2022 at 08:54:48PM -0800, Moritz Fischer wrote:
> Dinh,
> 
> On Tue, Jan 25, 2022 at 10:31:06PM -0600, Dinh Nguyen wrote:
> > 
> > 
> > On 1/25/22 19:07, Xu Yilun wrote:
> > > On Tue, Jan 25, 2022 at 01:28:53PM -0600, Dinh Nguyen wrote:
> > > > From: Richard Gong <richard.gong@intel.com>
> > > > 
> > > > Extend Intel service layer driver to get the firmware version running at
> > > > FPGA device. Therefore FPGA manager driver, one of Intel service layer
> > > > driver's client, can decide whether to handle the newly added bitstream
> > > > authentication function based on the retrieved firmware version.
> > > > 
> > > > Acked-by: Moritz Fischr <mdf@kernel.org>
> > > 
> > > This is already acked and no more change, is it? So please just ping in
> > > the original mail or add the [RESEND PATCH] prefix.
> > > 
> > > The patch is good to me.
> > > 
> > > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > > 
> > 
> > Thanks, I added Moritz Acked-by: is the only change.
> > 
> > Dinh
> 
> Did we traditionally take those through FPGA tree, did Greg pick those
> up?

This patch was the 3rd one of a patchset. It is acked but the patchset
is not, so we didn't take the single one in FPGA tree. This is the last
conversation.

https://lore.kernel.org/linux-fpga/YGDsl3VlIAnyJDzd@epycbox.lan/

Thanks,
Yilun

> 
> Cheers,
> Moritz
