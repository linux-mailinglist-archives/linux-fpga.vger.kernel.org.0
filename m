Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF9023D595
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Aug 2020 04:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgHFCqy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Aug 2020 22:46:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:31727 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgHFCqy (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 5 Aug 2020 22:46:54 -0400
IronPort-SDR: km/KR8PRN/Nij8Go8vonj+fuLrQJGI0rBINlR1H33UWfEaklJz7hFSnwwJ9NvDfmf6OhnV58A0
 VlOo6gior4xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="152669288"
X-IronPort-AV: E=Sophos;i="5.75,440,1589266800"; 
   d="scan'208";a="152669288"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 19:46:53 -0700
IronPort-SDR: JMPts0zLGa2TK4nZ6M81SgCrSmtUhNnShl1R21rIm7wIaMLTD6VNClCV3MU7E412fJa7zMqZVG
 GxMj3meML9Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,440,1589266800"; 
   d="scan'208";a="437387590"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 05 Aug 2020 19:46:51 -0700
Date:   Thu, 6 Aug 2020 10:43:22 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH v3 2/4] fpga: dfl: map feature mmio resources in their
 own  feature drivers
Message-ID: <20200806024322.GA7179@yilunxu-OptiPlex-7050>
References: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
 <1596524715-18038-3-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819B8C6D19C351CC9366685854B0@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819B8C6D19C351CC9366685854B0@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Aug 05, 2020 at 08:15:27PM +0800, Wu, Hao wrote:
> > Subject: [PATCH v3 2/4] fpga: dfl: map feature mmio resources in their own
> > feature drivers
> >
> > +static int dfl_binfo_prepare(struct build_feature_devs_info *binfo,
> > +     resource_size_t start, resource_size_t len)
> > +{
> > +struct device *dev = binfo->dev;
> > +void __iomem *ioaddr;
> > +
> > +if (!devm_request_mem_region(dev, start, len, dev_name(dev))) {
> > +dev_err(dev, "request region fail, start:%pa, len:%pa\n",
> > +&start, &len);
> > +return -EBUSY;
> > +}
> > +
> > +ioaddr = devm_ioremap(dev, start, len);
> > +if (!ioaddr) {
> > +dev_err(dev, "ioremap region fail, start:%pa, len:%pa\n",
> > +&start, &len);
> > +devm_release_mem_region(dev, start, len);
> 
> as it's devm_request_mem_region, do we still need to release it here?

Yes, I could delete it.

> > @@ -869,24 +935,24 @@ static int parse_feature_private(struct
> > build_feature_devs_info *binfo,
> >   *
> >   * @binfo: build feature devices information.
> >   * @dfl: device feature list to parse
> 
> Remove this line.

Yes.

Thanks,
Yilun.

> 
> Other place looks good to me.
> 
> Thanks
> Hao 
