Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0480627719
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Nov 2022 09:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiKNIGt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Nov 2022 03:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbiKNIGs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Nov 2022 03:06:48 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6161928A
        for <linux-fpga@vger.kernel.org>; Mon, 14 Nov 2022 00:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668413207; x=1699949207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mL/SiDeVvPxckhUEKBGnuj8k7yoI/XIJgh7jhUiptCY=;
  b=f3bSMxaL9RF5z6tvHNH114/X3ClYNvnHSsjo02W8uEeEXXiVc87iZE7H
   KDF0pdTcJRk7nINJ4/QKz97i0sY8IT2+XdSVnHI4J7WwGvEZ6DB9wnkRW
   lPs58Vxk8cKY1M+cUS/Dhg1c8TjJ/xogjesQ6BHu2bD8TB5Zk8fZD0eqe
   V/JjTxqFkAC+yaBYU7VNXjXZVyKH1QRxZPtDVUhoSwVPEcLyU4P00wPSw
   Mm5kJbBNts6O6l37AjuE7Qomm8ZFkp6/A3Jw5cTuGAc0CjbvJU7IbCb9c
   bRfDQIR896iba1wkupTLlYhcJZam63DB1JgID03QnzgUStBOsLN/452jg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="291626267"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="291626267"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 00:06:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="638381615"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="638381615"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga002.jf.intel.com with ESMTP; 14 Nov 2022 00:06:42 -0800
Date:   Mon, 14 Nov 2022 15:57:16 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: m10bmc-sec: Fix undefined reference error in
 m10bmc_sec_remove()
Message-ID: <Y3H03KV6tKVtk96c@yilunxu-OptiPlex-7050>
References: <20221112093446.61726-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112093446.61726-1-zhangqilong3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-11-12 at 17:34:46 +0800, Zhang Qilong wrote:
> Building with CONFIG_FW_LOADER=m && CONFIG_FW_UPLOAD=y causes
> errors:
> 
> ld: drivers/fpga/intel-m10-bmc-sec-update.o: in function `m10bmc_sec_remove':
> intel-m10-bmc-sec-update.c:(.text+0x25b): undefined reference to `firmware_upload_unregister'
> ld: drivers/fpga/intel-m10-bmc-sec-update.o: in function `m10bmc_sec_probe':
> intel-m10-bmc-sec-update.c:(.text+0x3c1): undefined reference to `firmware_upload_register'
> 
> When CONFIG_FW_LOADER is configed with module, the firmware_upload_unregister()
> could not be seen in m10bmc_sec_remove(), it is controlled by CONFIG_FW_UPLOAD
> that it depends CONFIG_FW_LOADER. We fix it by adding FW_LOADER in
> FPGA_M10_BMC_SEC_UPDATE depends.
> 
> Fixes: 5cd339b370e2 ("fpga: m10bmc-sec: add max10 secure update functions")
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>

Thanks for your patch, please check this thread:

https://lore.kernel.org/all/d81630d5-756c-4067-fc1b-47e5f56cad33@infradead.org/

Thanks,
Yilun
