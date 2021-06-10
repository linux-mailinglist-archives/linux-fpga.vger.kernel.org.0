Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD653A342C
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 21:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhFJTkR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Jun 2021 15:40:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:12986 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhFJTkR (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Jun 2021 15:40:17 -0400
IronPort-SDR: kz9/MZn8zsT+2+bD8KsGEbRKN0sUhbgRXWYwT5SmbanBzIFB6SRLML+SezDtZzp3UjSYDUebar
 2HoUs2LPjH1Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="291014360"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="291014360"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 12:38:20 -0700
IronPort-SDR: ZGVtf0+nskk5ChBxo2JFXyxQOdRVQtNRA6+D6j9p4z6LBMceAUXGX5yzukyZbPAEn0EnMBj32w
 YxxSPqbwWrcQ==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="477458858"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.184.121])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 12:38:20 -0700
Subject: Re: [PATCH v3 0/8] fpga: Populate dev_release functions
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com, richard.gong@intel.com
References: <20210610193422.286835-1-russell.h.weight@intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <f0e83bd2-4cb2-9fc8-2c6e-86a522f3afbe@intel.com>
Date:   Thu, 10 Jun 2021 12:38:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210610193422.286835-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

I think this version of the patch is ready to go. If you agree, please
provide a Reviewed-by or Tested-by tag.

Thanks,
- Russ

On 6/10/21 12:34 PM, Russ Weight wrote:
> The FPGA framework has a convention of using managed resource functions
> to allow parent drivers to manage the data structures allocated by the
> class drivers. They use an empty *_dev_release() function to satisfy the
> class driver.
>
> This is inconsistent with linux driver model.
>
> These changes populate the class dev_release callback functions while
> maintaining the current API.  Additional changes are made to maintain
> consistency with the driver model.
>
> For more context on these changes, refer to this email thread:
>
> https://marc.info/?l=linux-fpga&m=162127412218557&w=2
>
> Changelog v2 -> v3:
>   - Added Reviewed-by tags
>   - Moved a "dev" to "parent" rename in the comment header for
>     devm_fpga_region_create() from patch 8 to patch 5.
>
> Changelog v1 -> v2:
>   - Moved the renaming of "dev" to "parent" into a separate patch each for
>     fpga-mgr, fpga-bridge, fpga-region.
>   - Restored the call to fpga_mgr_free() in devm_*_mgr_release() instead of 
>     changing it to put_device().
>   - Replaced patch "fpga: altera-pr-ip: Remove function alt_pr_unregister"
>     with "fpga: altera-pr-ip: Remove function alt_pr_unregister". This patch
>     removes the alt_pr_unregister() function altogether, instead of just
>     removing portions of it.
>
> Russ Weight (8):
>   fpga: altera-pr-ip: Remove function alt_pr_unregister
>   fpga: stratix10-soc: Add missing fpga_mgr_free() call
>   fpga: mgr: Rename dev to parent for parent device
>   fpga: bridge: Rename dev to parent for parent device
>   fpga: region: Rename dev to parent for parent device
>   fpga: mgr: Use standard dev_release for class driver
>   fpga: bridge: Use standard dev_release for class driver
>   fpga: region: Use standard dev_release for class driver
>
>  drivers/fpga/altera-pr-ip-core.c       | 10 -----
>  drivers/fpga/fpga-bridge.c             | 46 ++++++++++-----------
>  drivers/fpga/fpga-mgr.c                | 55 ++++++++++++--------------
>  drivers/fpga/fpga-region.c             | 44 ++++++++++-----------
>  drivers/fpga/stratix10-soc.c           |  1 +
>  include/linux/fpga/altera-pr-ip-core.h |  1 -
>  6 files changed, 71 insertions(+), 86 deletions(-)
>

