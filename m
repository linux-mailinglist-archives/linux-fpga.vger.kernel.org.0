Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111532435A9
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Aug 2020 10:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgHMICY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 13 Aug 2020 04:02:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:1026 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgHMICX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 13 Aug 2020 04:02:23 -0400
IronPort-SDR: FvJyKvEI+LuaPQH9GVrSHekS475EqymQ4AEuOW9554K3K9y00XkIi+ZKSNdqq/LckZVws4XDtk
 csllVd5ghcaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="134233758"
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="scan'208";a="134233758"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 01:02:22 -0700
IronPort-SDR: hJHa6EByCKTPb/7dOEd3VrOHj+BBMkOiYAJrta41XHoD6PhjJMy/hLxs4lKYdonvAHaMwNAsqi
 A8JdD0AzJxFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="scan'208";a="318434407"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga004.fm.intel.com with ESMTP; 13 Aug 2020 01:02:21 -0700
Date:   Thu, 13 Aug 2020 15:58:43 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Moritz Fischer' <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: Re: [PATCH v4 1/4] fpga: dfl: change data type of feature id to u16
Message-ID: <20200813075843.GB7383@yilunxu-OptiPlex-7050>
References: <1597027273-25288-1-git-send-email-yilun.xu@intel.com>
 <1597027273-25288-2-git-send-email-yilun.xu@intel.com>
 <20200812035604.GA2544@epycbox.lan>
 <3810fb75b42e45928a39a97449a01520@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3810fb75b42e45928a39a97449a01520@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Aug 12, 2020 at 08:52:39AM +0000, David Laight wrote:
> From: Moritz Fischer
> > Sent: 12 August 2020 04:56
> > 
> > On Mon, Aug 10, 2020 at 10:41:10AM +0800, Xu Yilun wrote:
> > > The feature id is stored in a 12 bit field in DFH. So a u16 variable is
> > > enough for feature id.
> > >
> > > This patch changes all feature id related places to fit u16.
> 
> How much bigger does it make the kernel?

The patch changes the definition of feature id from u64 to u16, and will
make the kernel slightly smaller.

Actually it is not the main purpose of this change. In the following
patches we will put the feature_id definiton in mod_devicetable.h in
order to support MODULE_DEVICE_TABLE(). The modpost will also use the
definitions in mod_devicetable.h but seems it doesn't support u64 now.
So we reduced the unnecessary bits definition in feature_id to fit
modpost.

Thanks,
Yilun

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
