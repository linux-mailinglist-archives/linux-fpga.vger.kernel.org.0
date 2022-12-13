Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243A564AF67
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Dec 2022 06:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiLMFoG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Dec 2022 00:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiLMFoF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 13 Dec 2022 00:44:05 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9E217E2E;
        Mon, 12 Dec 2022 21:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670910243; x=1702446243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GlIRjLlouUWO1uozDPsslI/wfIy9NlpDuzuMY/D2txM=;
  b=gpbuNjTCJOoTT6hl7UlBi90QfVzIkGGwEv162NkWxpaWEagu+IXZFTJf
   fAvswbQga+6x+qpf/6gUd4HffzgLJ/+48DEwJIz6Azc51u6Cx4p/ekSkW
   1Qlusfdugg9qh0E1Qpq2GpUNY+vnyzGqun+ZAgrQcP1lN+y9vwVl46ajt
   d/vldXautHUhjSkLgmHtg24kRxuWzOMiVToCgRvhO9z63Tju8MhdnHCHS
   Gnl7H2cDUaMYNftI2n/+2qUGHBhAMQWNjV0Lzl5LHXd/slQIhR8PfFwjD
   1LmISqeK1VLBHGLKIyYQU7sG7TYWTxYSnGcod7nSfCbLMSdRUz+pWXAuE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="316750317"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="316750317"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 21:44:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="977326298"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="977326298"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2022 21:44:00 -0800
Date:   Tue, 13 Dec 2022 13:34:09 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/8] mfd: intel-m10-bmc: Create m10bmc_platform_info
 for type specific info
Message-ID: <Y5gO0US05awIxdTm@yilunxu-OptiPlex-7050>
References: <20221211103913.5287-1-ilpo.jarvinen@linux.intel.com>
 <20221211103913.5287-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221211103913.5287-2-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-11 at 12:39:06 +0200, Ilpo Järvinen wrote:
> BMC type specific info is currently set by a switch/case block. The
> size of this info is expected to grow as more dev types and features
> are added which would have made the switch block bloaty.
> 
> Store type specific info into struct and place them into .driver_data
> instead because it makes things a bit cleaner.
> 
> The m10bmc_type enum can be dropped as the differentiation is now
> fully handled by the platform info.
> 
> The info member of struct intel_m10bmc that is added here is not used
> yet in this change but its addition logically still belongs to this
> change. The CSR map change that comes after this change needs to have
> the info member.
> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>
