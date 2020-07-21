Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C3E227899
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jul 2020 08:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgGUGH5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Jul 2020 02:07:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:35784 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgGUGH5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 21 Jul 2020 02:07:57 -0400
IronPort-SDR: e2saD8L0YkKwEcQ0eCwASga0tTEnkyzrHRglS5+Sb1w1aClQdkFzy7a44dNN926EeiXZtr20n8
 iIF8cHnsYJkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="150055683"
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; 
   d="scan'208";a="150055683"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 23:07:56 -0700
IronPort-SDR: ZBa2I9rHxxMN6wzwKYTfntR4kstZg/MXfkLRjQDaZ5XRO2OfLRedZSwEk9NzTbvotAwOZhlrvT
 A4IBfiZJIA5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; 
   d="scan'208";a="431869766"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 20 Jul 2020 23:07:54 -0700
Date:   Tue, 21 Jul 2020 14:04:46 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     Tom Rix <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH 0/2] Modularization of DFL private feature drivers
Message-ID: <20200721060446.GC17091@yilunxu-OptiPlex-7050>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <0c7c63b8-5444-2deb-9fed-18956a5ad938@redhat.com>
 <DM6PR11MB38194C448ECCF1E6BF386D3F857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
 <237c776b-8746-421d-26ad-eea7242a9172@redhat.com>
 <DM6PR11MB3819828C1C193087AC6A4629857B0@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819828C1C193087AC6A4629857B0@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jul 20, 2020 at 05:21:43PM +0800, Wu, Hao wrote:
> > On 7/16/20 8:48 PM, Wu, Hao wrote:
> > >> Subject: Re: [PATCH 0/2] Modularization of DFL private feature drivers
> > >>
> > >> Generally i think this is a good approach.
> > >>
> > >> However I do have concern.
> > >>
> > >> The feature_id in dfl is magic number, similar to pci id but without a
> > vendor
> > >> id.
> > >>
> > >> Is it possible to add something like a vendor id so different vendors would
> > >> not have to be so careful to use a unique id ?
> > > Hi Tom,
> > >
> > > Thanks for the comments.
> > >
> > > Here is only one field defined in spec, that is feature id to distinguish one
> > > feature with another one. There is no vendor id here I think, and several
> > > cards are using this for now and seems not possible to change DFH format
> > > for these products. : (
> >
> > There looks like some unused bits in the first word, how about
> >
> > #define DFH_EOL            BIT_ULL(40)        /* End of list */
> >
> > +define DFH_VENDOR    GENMAKE_ULL(49,41) /* Vendor ID */
> >
> > #define DFH_TYPE        GENMASK_ULL(63, 60)    /* Feature type */
> >
> > And Intel gets id 0.
> >
> > >
> > > I fully understand the concern is the feature id management, and potential
> > > conflicts there from different vendors. One possible method to resolve this
> > > is managing the ids in a public place (web? Or just the driver header file for
> > > feature id definition), all vendors can request some feature ids, and other
> > > people can see which feature ids have been used so that they can avoid
> > > using conflict ones with other people.
> >
> > The conflict will come in development when two vendors use the same
> > unpublished feature id.
> >
> > Also keeping the truth of id's in the kernel source isn't that great because the
> > public kernel always lags development repositories.
> 
> I fully understand your point, and it's a good idea to me, but I am not sure if
> we can update the spec for DFHv0 at this moment. Let me check with spec
> owner about this. Actually I believe we don't want to add anything in driver
> code which is not defined in the spec at all. : (
> 
> >
> > >
> > > And in the later version DFH, this feature id will be replaced with GUID
> > > I think, so it can resolve the conflict problems from different vendors?
> > > But now, we still need to handle the existing ones. : )
> >
> > This is why I proposed needing to generalize the matching.
> 
> Personally I prefer that we can have standard matching functions per DFH
> specs.
> 
> Yilun, how do you think about this?

I also prefer we don't add anything now before DFL spec is updated.

The idea of extending the DFLv0 is good, but I'm not sure if it is necessary
now. It depends on how the customer is using the card, are they
developing more FME features themselves on current cards and want to make
them public.

I think we could discuss about the strategy. And we could add another
patchset if we finally decide and update the DFLv0 spec.

Thanks
Yilun

> 
> Thanks
> Hao
> 
