Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE2D12CBD8
	for <lists+linux-fpga@lfdr.de>; Mon, 30 Dec 2019 03:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfL3CNV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 29 Dec 2019 21:13:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:21692 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfL3CNV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 29 Dec 2019 21:13:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Dec 2019 18:13:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,373,1571727600"; 
   d="scan'208";a="269539410"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Dec 2019 18:13:18 -0800
Date:   Mon, 30 Dec 2019 09:53:12 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     yu kuai <yukuai3@huawei.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawe.com,
        zhengbin13@huawei.com
Subject: Re: [PATCH] fpga: dfl: afu: remove set but not used variable 'afu'
Message-ID: <20191230015312.GB6839@hao-dev>
References: <20191226121533.6017-1-yukuai3@huawei.com>
 <20191227225809.GB1643@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191227225809.GB1643@archbook>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Dec 27, 2019 at 02:58:09PM -0800, Moritz Fischer wrote:
> On Thu, Dec 26, 2019 at 08:15:33PM +0800, yu kuai wrote:
> > Fixes gcc '-Wunused-but-set-variable' warning:
> > 
> > drivers/fpga/dfl-afu-main.c: In function ‘afu_dev_destroy’:
> > drivers/fpga/dfl-afu-main.c:816:18: warning: variable ‘afu’
> > set but not used [-Wunused-but-set-variable]
> > 
> > It is never used, and so can be removed.
> > 
> > Signed-off-by: yu kuai <yukuai3@huawei.com>
> > ---
> >  drivers/fpga/dfl-afu-main.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> > index e4a34dc7947f..65437b6a6842 100644
> > --- a/drivers/fpga/dfl-afu-main.c
> > +++ b/drivers/fpga/dfl-afu-main.c
> > @@ -813,10 +813,8 @@ static int afu_dev_init(struct platform_device *pdev)
> >  static int afu_dev_destroy(struct platform_device *pdev)
> >  {
> >  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > -	struct dfl_afu *afu;
> >  
> >  	mutex_lock(&pdata->lock);
> > -	afu = dfl_fpga_pdata_get_private(pdata);
> >  	afu_mmio_region_destroy(pdata);
> >  	afu_dma_region_destroy(pdata);
> >  	dfl_fpga_pdata_set_private(pdata, NULL);
> > -- 
> > 2.17.2
> > 
> Acked-by: Moritz Fischer <mdf@kernel.org>
> 
> I'll get to the patches in the new year.

Thanks Kuai and Moritz. :)

Acked-by: Wu Hao <hao.wu@intel.com>

Hao
> 
> Thanks,
> Moritz
