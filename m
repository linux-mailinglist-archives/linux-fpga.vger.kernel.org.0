Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00E226AB8B
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Sep 2020 20:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgIOSJl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Sep 2020 14:09:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36428 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgIOSJH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Sep 2020 14:09:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id k13so1760950plk.3;
        Tue, 15 Sep 2020 11:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Avu9zQOxQ4NDvG2l7r65UNNFEBIgVGhnU50sKCSELa8=;
        b=NyrvaQs2n78Pp3f2Hb3IQjxUf+7JMXbD6OrXoutt50Rll+750vhUojlmI/gvWYXFv8
         QVOST/LkFJiZ7+4kDU03LoWn4wv7mSgzZE34ugi+tNldstsMqfVvxg9Q1JXFAOLK9eEJ
         F4Cf5xgv37fMXXYlNNSJ5AREyUjfNc6EEshKAxmxp4WpstXeT1M4vkZKkDr/4Ncc0tr1
         sWJhovp4FxNsdAt/VJurQwHz8husD1I3xU54/D8Jl6uh3TxnbvKJW4PEIcsVCSkawqLe
         BLmozi3rUrcNSawt1SPlsjpMEYLMTNtfoXuMtr19PtdJpQ2HB+BLsfegUIu+MpaOlB7Q
         LcgA==
X-Gm-Message-State: AOAM5300cqyLZpX0O1wlGhSxECV2LP7vGlKbGobBlLU1UaTEKmQhL00w
        Ag9jeyvcKCb6sQOObrMipnCYA5YHlQBphg==
X-Google-Smtp-Source: ABdhPJw9b1X9XAoDtwOubjNwl7RN9sTW6IBtcxixdLkExwz/fIo991YAFS99Un0/UM/MOUNNsvRYtQ==
X-Received: by 2002:a17:90a:d70b:: with SMTP id y11mr509884pju.15.1600193276623;
        Tue, 15 Sep 2020 11:07:56 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id o1sm14005705pfg.83.2020.09.15.11.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 11:07:56 -0700 (PDT)
Date:   Tue, 15 Sep 2020 11:07:55 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "Xu, Yilun" <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH v2 2/4] dfl: add dfl bus support to MODULE_DEVICE_TABLE()
Message-ID: <20200915180755.GA11862@epycbox.lan>
References: <1600140473-12351-1-git-send-email-yilun.xu@intel.com>
 <1600140473-12351-3-git-send-email-yilun.xu@intel.com>
 <20200915035927.GB2217@epycbox.lan>
 <DM6PR11MB381970CD3C77534AA3E4C76385200@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200915051933.GA13516@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819106F9D50E39F7CC7837D85200@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819106F9D50E39F7CC7837D85200@DM6PR11MB3819.namprd11.prod.outlook.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Hao, Xu,

On Tue, Sep 15, 2020 at 05:58:46AM +0000, Wu, Hao wrote:
> > On Tue, Sep 15, 2020 at 12:08:38PM +0800, Wu, Hao wrote:
> > > > On Tue, Sep 15, 2020 at 11:27:51AM +0800, Xu Yilun wrote:
> > > > > Device Feature List (DFL) is a linked list of feature headers within the
> > > > > device MMIO space. It is used by FPGA to enumerate multiple sub
> > features
> > > > > within it. Each feature can be uniquely identified by DFL type and
> > > > > feature id, which can be read out from feature headers.
> > > > >
> > > > > A dfl bus helps DFL framework modularize DFL device drivers for
> > different
> > > > > sub features. The dfl bus matches its devices and drivers by DFL type
> > and
> > > > > feature id.
> > > > >
> > > > > This patch add dfl bus support to MODULE_DEVICE_TABLE() by adding
> > info
> > > > > about struct dfl_device_id in devicetable-offsets.c and add a dfl entry
> > > > > point in file2alias.c.
> > > > >
> > > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > > > Acked-by: Wu Hao <hao.wu@intel.com>
> > >
> > > Yilun,
> > >
> > > I haven't acked-by this patch as it doesn't modify any dfl files, ideally you
> > 
> > Sorry, I misunderstood your comments "Acked-by: xxx for DFL related
> > changes after this fix".

Yeah it wasn't entirely clear to me either :)
> 
> Because the first patch contains changes to non-dfl files as well. : )
> 
> Hao
> 
> > 
> > > need acked-by from real maintainer of scripts/mod code, right?
> > 
> > Ideally yes. From the MAINTAINERS it is Masahiro Yamada, I added him on
> > the "to"
> > list. But I see some other patches (also for devtable entries) in kernel
> > don't have his acked-by.

Yeah, I've looked at that and most patches for those files seem to be
from subsystem maintainers. So I *think* it should be fine?

> > 
> > Hi Moritz:
> > 
> > Do you have any ideas on that?
> > 
> > Thanks,
> > Yilun.
> > 
> > >
> > > Thanks
> > > Hao
> > >
> > > > > ---
> > > > > v2: add comments for the format of modalias
> > > > > ---
> > > > >  scripts/mod/devicetable-offsets.c |  4 ++++
> > > > >  scripts/mod/file2alias.c          | 17 +++++++++++++++++
> > > > >  2 files changed, 21 insertions(+)
> > > > >
> > > > > diff --git a/scripts/mod/devicetable-offsets.c
> > b/scripts/mod/devicetable-
> > > > offsets.c
> > > > > index 27007c1..d8350ee 100644
> > > > > --- a/scripts/mod/devicetable-offsets.c
> > > > > +++ b/scripts/mod/devicetable-offsets.c
> > > > > @@ -243,5 +243,9 @@ int main(void)
> > > > >  DEVID(mhi_device_id);
> > > > >  DEVID_FIELD(mhi_device_id, chan);
> > > > >
> > > > > +DEVID(dfl_device_id);
> > > > > +DEVID_FIELD(dfl_device_id, type);
> > > > > +DEVID_FIELD(dfl_device_id, feature_id);
> > > > > +
> > > > >  return 0;
> > > > >  }
> > > > > diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> > > > > index 2417dd1..9fd2e60 100644
> > > > > --- a/scripts/mod/file2alias.c
> > > > > +++ b/scripts/mod/file2alias.c
> > > > > @@ -1368,6 +1368,22 @@ static int do_mhi_entry(const char
> > *filename,
> > > > void *symval, char *alias)
> > > > >  return 1;
> > > > >  }
> > > > >
> > > > > +/* Looks like: dfl:tNfN */
> > > > > +static int do_dfl_entry(const char *filename, void *symval, char *alias)
> > > > > +{
> > > > > +DEF_FIELD(symval, dfl_device_id, type);
> > > > > +DEF_FIELD(symval, dfl_device_id, feature_id);
> > > > > +
> > > > > +/*
> > > > > + * type contains 4 valid bits and feature_id contains 12 valid bits
> > > > > + * according to DFL specification.
> > > > > + */
> > > > > +sprintf(alias, "dfl:t%01Xf%03X", type, feature_id);
> > > > > +
> > > > > +add_wildcard(alias);
> > > > > +return 1;
> > > > > +}
> > > > > +
> > > > >  /* Does namelen bytes of name exactly match the symbol? */
> > > > >  static bool sym_is(const char *name, unsigned namelen, const char
> > > > *symbol)
> > > > >  {
> > > > > @@ -1442,6 +1458,7 @@ static const struct devtable devtable[] = {
> > > > >  {"tee", SIZE_tee_client_device_id, do_tee_entry},
> > > > >  {"wmi", SIZE_wmi_device_id, do_wmi_entry},
> > > > >  {"mhi", SIZE_mhi_device_id, do_mhi_entry},
> > > > > +{"dfl", SIZE_dfl_device_id, do_dfl_entry},
> > > > >  };
> > > > >
> > > > >  /* Create MODULE_ALIAS() statements.
> > > > > --
> > > > > 2.7.4
> > > > >
> > > > Applied to for-next,
> > > >
> > > > Thanks

Cheers,
Moritz
