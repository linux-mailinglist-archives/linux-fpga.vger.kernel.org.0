Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752291C6900
	for <lists+linux-fpga@lfdr.de>; Wed,  6 May 2020 08:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgEFGeY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 6 May 2020 02:34:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:11033 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgEFGeY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 6 May 2020 02:34:24 -0400
IronPort-SDR: VGepKPVIEyBk2vOerO5nqJmND77QuKypvgJ8keHisR9SDhLr3UPhFxeL0djCDuYZ36ebYdPPDT
 rEzIagXyAVBw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 23:34:23 -0700
IronPort-SDR: zohu/Jzm2U6NHWeWdrhykbxGsUjxNj49GrAWa95UbGk9vJMpvjDsiB24db9xNt4v3WwevYbtB4
 1il8KSDdsf2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,358,1583222400"; 
   d="scan'208";a="407126071"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2020 23:34:22 -0700
Date:   Wed, 6 May 2020 14:31:23 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     hao.wu@intel.com, linux-fpga@vger.kernel.org
Subject: Re: [bug report] fpga: dfl: fme: add performance reporting support
Message-ID: <20200506063123.GA22708@yilunxu-OptiPlex-7050>
References: <20200502132419.GA41486@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502132419.GA41486@mwanda>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, May 02, 2020 at 04:24:19PM +0300, Dan Carpenter wrote:
> Hello Wu Hao,
> 
> The patch 724142f8c42a: "fpga: dfl: fme: add performance reporting
> support" from Apr 27, 2020, leads to the following static checker
> warning:
> 
> 	drivers/fpga/dfl-fme-perf.c:948 fme_perf_offline_cpu()
> 	error: potential NULL dereference 'priv'.
> 
> drivers/fpga/dfl-fme-perf.c
>    941  static int fme_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
>    942  {
>    943          struct fme_perf_priv *priv;
>    944          int target;
>    945  
>    946          priv = hlist_entry_safe(node, struct fme_perf_priv, node);
>                                   ^^^^^
> It doesn't make sense to use the _safe() version if we're not going to
> check for NULL.

Thanks for catching this. Will fix it.

Regards,
Yilun.

> 
>    947  
>    948          if (cpu != priv->cpu)
>    949                  return 0;
>    950  
>    951          target = cpumask_any_but(cpu_online_mask, cpu);
>    952          if (target >= nr_cpu_ids)
>    953                  return 0;
>    954  
>    955          priv->cpu = target;
>    956          return 0;
>    957  }
> 
> regards,
> dan carpenter
