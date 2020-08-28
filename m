Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB6725542A
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Aug 2020 08:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgH1GAI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 Aug 2020 02:00:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:35794 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgH1GAH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 28 Aug 2020 02:00:07 -0400
IronPort-SDR: RvNbL0lzqj8HYRC6ReaFedLaBQkRQev0btJZ3bBMCiu/VE+SCqKJ7FPlSEqGjHqo5ufsGB3lLQ
 /k0aa4X1+bag==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="136677957"
X-IronPort-AV: E=Sophos;i="5.76,362,1592895600"; 
   d="scan'208";a="136677957"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 23:00:04 -0700
IronPort-SDR: McsTh8G5D3tbZMqZlooEqwZTeP1Uyb5WLzaHsn6IM/SQPxe/wRQqU9dcd9Qrwpd32yBG1b+lUb
 OtfWWPNgvdeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,362,1592895600"; 
   d="scan'208";a="300117330"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga006.jf.intel.com with ESMTP; 27 Aug 2020 23:00:02 -0700
Date:   Fri, 28 Aug 2020 13:56:03 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: Re: [PATCH v4 1/4] fpga: dfl: change data type of feature id to u16
Message-ID: <20200828055603.GA5814@yilunxu-OptiPlex-7050>
References: <1597027273-25288-1-git-send-email-yilun.xu@intel.com>
 <1597027273-25288-2-git-send-email-yilun.xu@intel.com>
 <20200812035604.GA2544@epycbox.lan>
 <3810fb75b42e45928a39a97449a01520@AcuMS.aculab.com>
 <20200813075843.GB7383@yilunxu-OptiPlex-7050>
 <54216e492cec4f84bc43dee176130e89@AcuMS.aculab.com>
 <20200813090409.GA1080@yilunxu-OptiPlex-7050>
 <20200820041431.GB4022@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820041431.GB4022@epycbox.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Aug 19, 2020 at 09:14:31PM -0700, Moritz Fischer wrote:
> On Thu, Aug 13, 2020 at 05:04:09PM +0800, Xu Yilun wrote:
> > On Thu, Aug 13, 2020 at 08:28:05AM +0000, David Laight wrote:
> > > From: Xu Yilun
> > > > Sent: 13 August 2020 08:59
> > > > On Wed, Aug 12, 2020 at 08:52:39AM +0000, David Laight wrote:
> > > > > From: Moritz Fischer
> > > > > > Sent: 12 August 2020 04:56
> > > > > >
> > > > > > On Mon, Aug 10, 2020 at 10:41:10AM +0800, Xu Yilun wrote:
> > > > > > > The feature id is stored in a 12 bit field in DFH. So a u16 variable is
> > > > > > > enough for feature id.
> > > > > > >
> > > > > > > This patch changes all feature id related places to fit u16.
> > > > >
> > > > > How much bigger does it make the kernel?
> > > > 
> > > > The patch changes the definition of feature id from u64 to u16, and will
> > > > make the kernel slightly smaller.
> > > 
> > > Unlikely.
> > > Most of the structures will gain a 'pad' field.
> > > Using u16 for function parameters and results almost certainly
> > > requires instructions to mask the value.
> > > Any arithmetic on u16 will require masking instructions on
> > > (probably) all architectures except x86.
> > > 
> > > Using 'unsigned int' is probably best.
> > > 
> > > u16 is never a good idea unless you are defining enough
> > > of them in a structure (eg as an array) to reduce the
> > > structure size below some threshold.
> > > (Or are matching some hardware layout.)
> > 
> > I got it. Thanks for your detailed explanation. I think we may change them to
> > u32. Is it the same case for u8? Think we may also change the dfl_device_id.type.
> > 
> > 
> > Hi Moritz:
> > 
> > The patch is applied to for-next, is it possible we recall it, or we
> > make another fix after it?
> > 
> > Thanks,
> > Yilun.
> 
> Sorry for the delay, can you send a follow-up please?

Hi moritz:

I think I don't have to change it now. As discussed with David, these
fields aren't often accessed. So it should be OK.

Thanks,
Yilun.

> 
> Cheers,
> Moritz
