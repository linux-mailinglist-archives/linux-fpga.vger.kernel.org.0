Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B27626B7C7
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Sep 2020 02:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgIPA3a (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Sep 2020 20:29:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:64608 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgIPA3Z (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Sep 2020 20:29:25 -0400
IronPort-SDR: mMLr+s1a5HGdwbkck8gd8nD2MLd6LwhsXtD8tF8FxhHLeNrgo4+BpxOi3L+PUQdUwWDOTBmeD6
 mrsIqwZehUQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="147127009"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="147127009"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 17:29:24 -0700
IronPort-SDR: isOkeQWRIriQfz2XHlRw4RgNA0C5U/TrxLMuEgAX/XMAX+Z4RkAWoEXYMfjSnGqHvvfrJTQoj/
 P6+k6358ZsLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="507795288"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 15 Sep 2020 17:29:22 -0700
Date:   Wed, 16 Sep 2020 08:24:59 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     "Wu, Hao" <hao.wu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH v2 2/4] dfl: add dfl bus support to MODULE_DEVICE_TABLE()
Message-ID: <20200916002458.GA30711@yilunxu-OptiPlex-7050>
References: <1600140473-12351-1-git-send-email-yilun.xu@intel.com>
 <1600140473-12351-3-git-send-email-yilun.xu@intel.com>
 <20200915035927.GB2217@epycbox.lan>
 <DM6PR11MB381970CD3C77534AA3E4C76385200@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200915051933.GA13516@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819106F9D50E39F7CC7837D85200@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200915180755.GA11862@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915180755.GA11862@epycbox.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 15, 2020 at 11:07:55AM -0700, Moritz Fischer wrote:
> Hi Hao, Xu,
> 
> On Tue, Sep 15, 2020 at 05:58:46AM +0000, Wu, Hao wrote:
> > > On Tue, Sep 15, 2020 at 12:08:38PM +0800, Wu, Hao wrote:
> > > > > On Tue, Sep 15, 2020 at 11:27:51AM +0800, Xu Yilun wrote:
> > > > > > Device Feature List (DFL) is a linked list of feature headers within the
> > > > > > device MMIO space. It is used by FPGA to enumerate multiple sub
> > > features
> > > > > > within it. Each feature can be uniquely identified by DFL type and
> > > > > > feature id, which can be read out from feature headers.
> > > > > >
> > > > > > A dfl bus helps DFL framework modularize DFL device drivers for
> > > different
> > > > > > sub features. The dfl bus matches its devices and drivers by DFL type
> > > and
> > > > > > feature id.
> > > > > >
> > > > > > This patch add dfl bus support to MODULE_DEVICE_TABLE() by adding
> > > info
> > > > > > about struct dfl_device_id in devicetable-offsets.c and add a dfl entry
> > > > > > point in file2alias.c.
> > > > > >
> > > > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > > > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > > > > Acked-by: Wu Hao <hao.wu@intel.com>
> > > >
> > > > Yilun,
> > > >
> > > > I haven't acked-by this patch as it doesn't modify any dfl files, ideally you
> > > 
> > > Sorry, I misunderstood your comments "Acked-by: xxx for DFL related
> > > changes after this fix".
> 
> Yeah it wasn't entirely clear to me either :)
> > 
> > Because the first patch contains changes to non-dfl files as well. : )
> > 
> > Hao
> > 
> > > 
> > > > need acked-by from real maintainer of scripts/mod code, right?
> > > 
> > > Ideally yes. From the MAINTAINERS it is Masahiro Yamada, I added him on
> > > the "to"
> > > list. But I see some other patches (also for devtable entries) in kernel
> > > don't have his acked-by.
> 
> Yeah, I've looked at that and most patches for those files seem to be
> from subsystem maintainers. So I *think* it should be fine?

I see you have applied the patch. I'm very fine. :)

> 
> > > 
> > > Hi Moritz:
> > > 
> > > Do you have any ideas on that?
> > > 
> > > Thanks,
> > > Yilun.
> > > 
> > > >
> > > > Thanks
> > > > Hao
> > > >
> > > > > > ---
> > > > > > v2: add comments for the format of modalias
> > > > > > ---
> > > > > >  scripts/mod/devicetable-offsets.c |  4 ++++
> > > > > >  scripts/mod/file2alias.c          | 17 +++++++++++++++++
> > > > > >  2 files changed, 21 insertions(+)
> > > > > >
> > > > > > diff --git a/scripts/mod/devicetable-offsets.c
> > > b/scripts/mod/devicetable-
> > > > > offsets.c
> > > > > > index 27007c1..d8350ee 100644
> > > > > > --- a/scripts/mod/devicetable-offsets.c
> > > > > > +++ b/scripts/mod/devicetable-offsets.c
> > > > > > @@ -243,5 +243,9 @@ int main(void)
> > > > > >  DEVID(mhi_device_id);
> > > > > >  DEVID_FIELD(mhi_device_id, chan);
> > > > > >
> > > > > > +DEVID(dfl_device_id);
> > > > > > +DEVID_FIELD(dfl_device_id, type);
> > > > > > +DEVID_FIELD(dfl_device_id, feature_id);
> > > > > > +
> > > > > >  return 0;
> > > > > >  }
> > > > > > diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> > > > > > index 2417dd1..9fd2e60 100644
> > > > > > --- a/scripts/mod/file2alias.c
> > > > > > +++ b/scripts/mod/file2alias.c
> > > > > > @@ -1368,6 +1368,22 @@ static int do_mhi_entry(const char
> > > *filename,
> > > > > void *symval, char *alias)
> > > > > >  return 1;
> > > > > >  }
> > > > > >
> > > > > > +/* Looks like: dfl:tNfN */
> > > > > > +static int do_dfl_entry(const char *filename, void *symval, char *alias)
> > > > > > +{
> > > > > > +DEF_FIELD(symval, dfl_device_id, type);
> > > > > > +DEF_FIELD(symval, dfl_device_id, feature_id);
> > > > > > +
> > > > > > +/*
> > > > > > + * type contains 4 valid bits and feature_id contains 12 valid bits
> > > > > > + * according to DFL specification.
> > > > > > + */
> > > > > > +sprintf(alias, "dfl:t%01Xf%03X", type, feature_id);
> > > > > > +
> > > > > > +add_wildcard(alias);
> > > > > > +return 1;
> > > > > > +}
> > > > > > +
> > > > > >  /* Does namelen bytes of name exactly match the symbol? */
> > > > > >  static bool sym_is(const char *name, unsigned namelen, const char
> > > > > *symbol)
> > > > > >  {
> > > > > > @@ -1442,6 +1458,7 @@ static const struct devtable devtable[] = {
> > > > > >  {"tee", SIZE_tee_client_device_id, do_tee_entry},
> > > > > >  {"wmi", SIZE_wmi_device_id, do_wmi_entry},
> > > > > >  {"mhi", SIZE_mhi_device_id, do_mhi_entry},
> > > > > > +{"dfl", SIZE_dfl_device_id, do_dfl_entry},
> > > > > >  };
> > > > > >
> > > > > >  /* Create MODULE_ALIAS() statements.
> > > > > > --
> > > > > > 2.7.4
> > > > > >
> > > > > Applied to for-next,
> > > > >
> > > > > Thanks
> 
> Cheers,
> Moritz
