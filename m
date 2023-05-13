Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F321B7014E3
	for <lists+linux-fpga@lfdr.de>; Sat, 13 May 2023 09:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjEMHGu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 13 May 2023 03:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMHGs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 13 May 2023 03:06:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDA0132;
        Sat, 13 May 2023 00:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683961607; x=1715497607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r8cD00ffGcYxM9st2Yop+R27YZAOvLBovDPzCFmiTUk=;
  b=Pa7L/zX7wG/9FoAd6R5faeQj7qa7SoNes8KBicLG9gYHM3oFnDeYzd4y
   yfZIx+qdtO08srRdnBCyVBmA3dFrlBoSAOosnEUnXPIZbExn0ilp7Z61L
   qWtzP+MeDrNDHIxl1NrSxv04d1xwrKC58F6p37QrW73EALVnUgwdGdANP
   NCUxznoh9/wqQEpZ+MAGdt71PFDOkYhih8s5xjn4yirlp435RHuAlMfrU
   YXzeIlQwDVTtd0cuU4kGwNXSCO8ME1cqaVXm9mUfrzMfC5vjsi6wTKBQz
   onrQ+nbVA0w14E4zW74jMnUkjRkPQSTHspBh5AU044sQMEbj1sM8zVcn2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="335459083"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="335459083"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 00:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="700409617"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="700409617"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga002.jf.intel.com with ESMTP; 13 May 2023 00:06:44 -0700
Date:   Sat, 13 May 2023 23:06:44 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [RESEND PATCH] fpga: dfl-fme: constify pointers to
 hwmon_channel_info
Message-ID: <ZF+nhOPhgLMqI6Um@yilunxu-OptiPlex-7050>
References: <20230511175449.282069-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511175449.282069-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-05-11 at 19:54:49 +0200, Krzysztof Kozlowski wrote:
> Statically allocated array of pointers to hwmon_channel_info can be made
> const for safety.
> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.
