Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 520419718F
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Aug 2019 07:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfHUF30 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Aug 2019 01:29:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:44343 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfHUF30 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 21 Aug 2019 01:29:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 22:29:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,411,1559545200"; 
   d="scan'208";a="190088616"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga002.jf.intel.com with ESMTP; 20 Aug 2019 22:29:23 -0700
Date:   Wed, 21 Aug 2019 13:12:04 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org
Subject: Re: [PATCH v5 1/9] fpga: dfl: make init callback optional
Message-ID: <20190821051204.GA27866@hao-dev>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
 <1565578204-13969-2-git-send-email-hao.wu@intel.com>
 <20190821032406.GA28625@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821032406.GA28625@archbox>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Aug 20, 2019 at 08:24:06PM -0700, Moritz Fischer wrote:
> Hi,
> 
> On Mon, Aug 12, 2019 at 10:49:56AM +0800, Wu Hao wrote:
> > This patch makes init callback of sub features optional. With
> > this change, people don't need to prepare any empty init callback.
> > 
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> 
> Acked-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  drivers/fpga/dfl.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index c0512af..96a2b82 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -271,11 +271,13 @@ static int dfl_feature_instance_init(struct platform_device *pdev,
> >  				     struct dfl_feature *feature,
> >  				     struct dfl_feature_driver *drv)
> >  {
> > -	int ret;
> > +	int ret = 0;
> >  
> > -	ret = drv->ops->init(pdev, feature);
> > -	if (ret)
> > -		return ret;
> > +	if (drv->ops->init) {
> > +		ret = drv->ops->init(pdev, feature);
> > +		if (ret)
> > +			return ret;
> > +	}
> >  
> >  	feature->ops = drv->ops;
> 
> You could swap it around maybe like so:
> 
> int dfl_feature_instance_init() ...
> {
> 	feature->ops = drv->ops;
> 	if (drv->ops->init)
> 		return drv->ops->init(pdev, feature);
> 
> 	return 0;
> }
> 
> With the caveat that feature->ops gets always set ...
> 
> Your call.

Hi Moritz,

Thanks a lot for the review and comments. It does simplify the code,
will modify it.

Thanks
Hao

> 
> Thanks,
> Moritz
