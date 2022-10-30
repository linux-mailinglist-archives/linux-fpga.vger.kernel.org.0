Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8228612D3E
	for <lists+linux-fpga@lfdr.de>; Sun, 30 Oct 2022 23:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJ3WGi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 30 Oct 2022 18:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3WGh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 30 Oct 2022 18:06:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13EC7651;
        Sun, 30 Oct 2022 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667167596; x=1698703596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IlxZQ6qxXfEbM/XmZBwTjN/fapBFZBIks0uyy63At0A=;
  b=JRwSZnyvLAIbEUoJkTAgG4AVaiZcWXu8ZXSuMAUSCn9/mDQoGxtH01hm
   GJfXwZIPyggoBH/f3prg954QFZo6q1LmdkEbjubsyu90KLafYOFkUNZS4
   MtuOh/vGPJGdwsG/E6UVS1XebehW8nZwcqmR6OjxyeZ9BDfUfG+t4LyAI
   EsYX5OIMMzZ3ZvtOM4ryuHk7cJEgoWSj6SNEN4CuQNXlf9oI1pTgQoX2R
   R9uLNpcLFeh1uFCYdvv/ReF7C/BPKuwEbdALGv67K5oo7lv2kFG67OIt/
   rWgNKNwhmCywZ1NPCMTDXOpFs9pRaNUxW+v7qMnKMLTrXMGTBTw+AXFku
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="288496655"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="288496655"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 15:06:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="628055229"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="628055229"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2022 15:06:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1opGRo-004phz-28;
        Mon, 31 Oct 2022 00:06:28 +0200
Date:   Mon, 31 Oct 2022 00:06:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     matthew.gerlach@linux.intel.com, hao.wu@intel.com,
        russell.h.weight@intel.com, basheer.ahmed.muddebihal@intel.com,
        trix@redhat.com, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net, jirislaby@kernel.org,
        geert+renesas@glider.be, niklas.soderlund+renesas@ragnatech.se,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de,
        ilpo.jarvinen@linux.intel.com, marpagan@redhat.com
Subject: Re: [PATCH v4 3/4] fpga: dfl: add basic support DFHv1
Message-ID: <Y171ZEHpOydtR4dW@smile.fi.intel.com>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com>
 <20221020212610.697729-4-matthew.gerlach@linux.intel.com>
 <Y10l3NkIn0gsdVZq@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y10l3NkIn0gsdVZq@yilunxu-OptiPlex-7050>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Oct 29, 2022 at 09:08:44PM +0800, Xu Yilun wrote:
> On 2022-10-20 at 14:26:09 -0700, matthew.gerlach@linux.intel.com wrote:

> >  struct dfl_feature_info {
> >  	u16 fid;
> >  	u8 revision;
> > +	u8 dfh_version;
> >  	struct resource mmio_res;
> >  	void __iomem *ioaddr;
> >  	struct list_head node;
> >  	unsigned int irq_base;
> >  	unsigned int nr_irqs;
> > +	unsigned int param_size;
> > +	u64 params[];
> >  };

...

> > +	finfo = kzalloc(sizeof(*finfo) + dfh_psize, GFP_KERNEL);


This probably may use something from overflow.h.

> The u64 flexible array in the structure, but seems dfh_get_psize could
> not garantee 64bit aligned size.
> 
> What's the mandatory alignment of param data? If 64bit aligned, bit 33-34
> of PARAM_HDR should be reserved. If 32bit aligned, finfo:params should be
> u32[].

Isn't it guaranteed by the C standard / architecture ABI?

-- 
With Best Regards,
Andy Shevchenko


