Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FA6515E38
	for <lists+linux-fpga@lfdr.de>; Sat, 30 Apr 2022 16:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382836AbiD3OgD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 30 Apr 2022 10:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239177AbiD3OgC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 30 Apr 2022 10:36:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B608017048;
        Sat, 30 Apr 2022 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651329160; x=1682865160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5n9k9ZqfREXkHj6Rcus3Ptw9qG95yOLcMZ9wKQUwq7c=;
  b=WtRUDu2Slk69CMvPNKeE8RwazDAuFuU83mqVubpYtq6EwRoMsqc9byNk
   BVwHGzigWr84TgEeKov9tin9VIrUu/q7LXBLMBjnu5PbtgflG3MDb/Cbj
   nBcRrLA1+AFBM9h/6H2L7/3RJxpAbAZUIsRg+GIuOBDnKym3wlm79aLA5
   1Q3g+k6biS2aRmGLPTSQtnTawrorR1udgzIgcwD5WmSjs89nkuo1FnzHs
   Cmxrba9A6Tuy4nI2QlNlSlokUro+JGoQuB6+9XMUIuX4zjPSNIK9xEtOo
   67LL+OA+uCTD6biKErIyoZO3KO4XQXOeo4O+1MFGyYG/0nyV/+5nrHPDO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="265736052"
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="265736052"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 07:32:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="706978136"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga001.fm.intel.com with ESMTP; 30 Apr 2022 07:32:38 -0700
Date:   Sat, 30 Apr 2022 22:24:52 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Tianfei Zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v3] uio: dfl: add HSSI subsystem feature id
Message-ID: <20220430142452.GB398931@yilunxu-OptiPlex-7050>
References: <20220429005726.607804-1-tianfei.zhang@intel.com>
 <b3f0bc47-70ea-2da5-2891-3b01550c6da6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3f0bc47-70ea-2da5-2891-3b01550c6da6@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Apr 29, 2022 at 05:23:53AM -0700, Tom Rix wrote:
> 
> On 4/28/22 5:57 PM, Tianfei Zhang wrote:
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > 
> > Add the Device Feature List (DFL) feature id for the
> > High Speed Serial Interface (HSSI) Subsystem to the
> > table of ids supported by the uio_dfl driver.
> > 
> > The HSSI Subsystem is a configurable set of IP blocks
> > to be used as part of a Ethernet or PCS/FEC/PMA pipeline.
> > Like the Ethernet group used by the N3000 card, the HSSI
> > Subsystem does not fully implement a network device from
> > a Linux netdev perspective and is controlled and monitored
> > from user space software via the uio interface.
> 
> Generally you should include the url for the dfl definitions.
> 
> Can you add it here to the commit log ?

Do you refer to this url, https://github.com/OPAE/dfl-feature-id ?

Hao has some comments about this at

  https://lore.kernel.org/all/DM6PR11MB38190E6EEF6DE3EB900290C585F39@DM6PR11MB3819.namprd11.prod.outlook.com/

> 
> Otherwise fine.
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
> 
> > 
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>

This patch is now good to me.

Acked-by: Xu Yilun <yilun.xu@intel.com>

> > ---
> > v3: change the name of this feature id to HSSI_SUBSYS and rewrite
> >      the git message.
> > v2: add HSSI introduction and the git repo of Feature ID table.
> > ---
> >   drivers/uio/uio_dfl.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
> > index 89c0fc7b0cbc..8f39cc8bb034 100644
> > --- a/drivers/uio/uio_dfl.c
> > +++ b/drivers/uio/uio_dfl.c
> > @@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
> >   }
> >   #define FME_FEATURE_ID_ETH_GROUP	0x10
> > +#define FME_FEATURE_ID_HSSI_SUBSYS	0x15
> >   static const struct dfl_device_id uio_dfl_ids[] = {
> >   	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> > +	{ FME_ID, FME_FEATURE_ID_HSSI_SUBSYS },
> >   	{ }
> >   };
> >   MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
