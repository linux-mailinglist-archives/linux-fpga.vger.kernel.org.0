Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98032DA5C5
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Dec 2020 02:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgLOBpB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Dec 2020 20:45:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:60795 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbgLOBow (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Dec 2020 20:44:52 -0500
IronPort-SDR: pFW/BJSO2otIVZCRo98dW/cIok02JNyXzutgGuI4EZHGhvSMkkHqISPdhDLXi1jpdG2CnS5BsV
 Aqz/psSNxMRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="154617961"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="154617961"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 17:44:11 -0800
IronPort-SDR: kGKFZqd/EndEykydqTA63hXMkGDOOsgvjxwnizEEx2zj9k8qnpx1j+WDeHawd9+c4BZMC5mdSK
 jW3uFCYJyleg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="367838697"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga008.jf.intel.com with ESMTP; 14 Dec 2020 17:44:09 -0800
Date:   Tue, 15 Dec 2020 09:39:55 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, hao.wu@intel.com,
        russell.h.weight@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH 5/8] fpga: dfl: add dfl bus support to
  MODULE_DEVICE_TABLE()
Message-ID: <20201215013954.GA14854@yilunxu-OptiPlex-7050>
References: <20201210165804.44234-1-mdf@kernel.org>
 <20201210165804.44234-6-mdf@kernel.org>
 <1cda7c87-aff0-d250-274a-15419e3d6939@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cda7c87-aff0-d250-274a-15419e3d6939@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Dec 14, 2020 at 05:43:53AM -0800, Tom Rix wrote:
> 
> On 12/10/20 8:58 AM, Moritz Fischer wrote:
> > From: Xu Yilun <yilun.xu@intel.com>
> >
> > Device Feature List (DFL) is a linked list of feature headers within the
> > device MMIO space. It is used by FPGA to enumerate multiple sub features
> > within it. Each feature can be uniquely identified by DFL type and
> > feature id, which can be read out from feature headers.
> >
> > A dfl bus helps DFL framework modularize DFL device drivers for
> > different sub features. The dfl bus matches its devices and drivers by
> > DFL type and feature id.
> >
> > This patch adds dfl bus support to MODULE_DEVICE_TABLE() by adding info
> > about struct dfl_device_id in devicetable-offsets.c and add a dfl entry
> > point in file2alias.c.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > Acked-by: Wu Hao <hao.wu@intel.com>
> > ---
> >  scripts/mod/devicetable-offsets.c |  4 ++++
> >  scripts/mod/file2alias.c          | 13 +++++++++++++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
> > index 27007c18e754..d8350eea6d1a 100644
> > --- a/scripts/mod/devicetable-offsets.c
> > +++ b/scripts/mod/devicetable-offsets.c
> > @@ -243,5 +243,9 @@ int main(void)
> >  	DEVID(mhi_device_id);
> >  	DEVID_FIELD(mhi_device_id, chan);
> 
> addition of auxiliary_device_id causes a trivial conflict.
> 
> Do you want me resolve and resend the set ?

Seems we should wait until 5.11-rc1, I'll rebase and resolve the
conflict then.

Thanks,
Yilun
