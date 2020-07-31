Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E280234083
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Jul 2020 09:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbgGaHwB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 31 Jul 2020 03:52:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:13718 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731644AbgGaHwB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 31 Jul 2020 03:52:01 -0400
IronPort-SDR: 6F57SUpNbWNTm40CXnJtdn1M05WFAUOtrSL0Ul1g4cvc2uwA5hJXTwr3MBxhEMHHmJs5+1FrVM
 scSaeswrG8fA==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="131814521"
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="131814521"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 00:52:01 -0700
IronPort-SDR: M8ti5At6xlNbOSGTKMfP8IK/cxxE22unkj68z36ICBUkGC8VCRBD0WThjuxVIbb1ml6gDxvL8k
 1zdznFCc+EMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="490942058"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jul 2020 00:51:59 -0700
Date:   Fri, 31 Jul 2020 15:48:37 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com
Subject: Re: [PATCH v2 1/4] fpga: dfl: change data type of feature id to u16
Message-ID: <20200731074837.GE1781@yilunxu-OptiPlex-7050>
References: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
 <1595556555-9903-2-git-send-email-yilun.xu@intel.com>
 <316f86d4-7bba-f0c7-3dde-794df80d32e7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <316f86d4-7bba-f0c7-3dde-794df80d32e7@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Jul 25, 2020 at 06:29:53AM -0700, Tom Rix wrote:
> It would be good if the variable or element for the feature id had a consistent name.
> 
> 
> > @@ -197,7 +197,7 @@ int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id);
> >   * @id: unique dfl private feature id.
> >   */
> >  struct dfl_feature_id {
> > -	u64 id;
> > +	u16 id;
> >  };
> 
> Is this structure needed ?
> 
> Here is how it could be changed to 
> 
> struct dfl_feature_driver {
> 
> -    const dfl_feature_id *
> 
> +    const u16 *id_table;

This structure is to represent an id type, which is used to match
fme/port owned features. It could be extended if some feature drivers
needs driver_data.

Actually I see some example of device_ids with similar structure, like:

  struct mips_cdmm_device_id {
  	__u8	type;
  };

  struct tee_client_device_id {
	uuid_t uuid;
  };


Thanks,
Yilun.

> 
> ...
> 
> Tom
> 
> 
> >  
> >  /**
> > @@ -240,7 +240,7 @@ struct dfl_feature_irq_ctx {
> >   */
> >  struct dfl_feature {
> >  	struct platform_device *dev;
> > -	u64 id;
> > +	u16 id;
> >  	int resource_index;
> >  	void __iomem *ioaddr;
> >  	struct dfl_feature_irq_ctx *irq_ctx;
> > @@ -371,7 +371,7 @@ struct platform_device *dfl_fpga_inode_to_feature_dev(struct inode *inode)
> >  	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
> >  
> >  static inline
> > -struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
> > +struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u16 id)
> >  {
> >  	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> >  	struct dfl_feature *feature;
> > @@ -384,7 +384,7 @@ struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
> >  }
> >  
> >  static inline
> > -void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
> > +void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
> >  {
> >  	struct dfl_feature *feature = dfl_get_feature_by_id(dev, id);
> >  
> > @@ -395,7 +395,7 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
> >  	return NULL;
> >  }
> >  
> > -static inline bool is_dfl_feature_present(struct device *dev, u64 id)
> > +static inline bool is_dfl_feature_present(struct device *dev, u16 id)
> >  {
> >  	return !!dfl_get_feature_ioaddr_by_id(dev, id);
> >  }
