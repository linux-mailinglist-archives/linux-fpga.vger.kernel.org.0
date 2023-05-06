Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7119A6F8DCF
	for <lists+linux-fpga@lfdr.de>; Sat,  6 May 2023 03:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjEFB5s (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 5 May 2023 21:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjEFB5r (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 5 May 2023 21:57:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14094EC5;
        Fri,  5 May 2023 18:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683338262; x=1714874262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b+C4AYP9JU2KJ1hzN20KFohvea7hRzEwFH1d9gSgAOU=;
  b=dKvYkPMW2b1Ln2FfGxPQu/EuqMdNXDeSWZi8RnK+Q/yJASLYOimJmTfL
   O/a8HToCoUQpkYqWwIlAtlQM8MSdD80zQj+v0BeUsMGgvT27PGKWXxJM6
   Nz1Nl6+sEuQzx9CJiR+PGe+u4mQBNMNpBczfaja4M1aEyPs5Skngw5GGo
   OIGkHPXlIhGU9fd7UjVPnAw4L1qAlMl0X4Ig/F8ub1r2olpwd73E8hGsL
   WdWtDs+0ex+9nYY0xB23vN6a62lh3t+CguFpGbXTewW74hQXD3V/yFbfT
   UribIfdsLydt2At04JkEnXZ083BPfLKBrG/yYJ2Gf6kgq1xu7M8CPLh7K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="349368877"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="349368877"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 18:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="841998191"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="841998191"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2023 18:57:39 -0700
Date:   Sat, 6 May 2023 17:57:49 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Vladimir Georgiev <v.georgiev@metrotek.ru>
Cc:     conor.dooley@microchip.com, devicetree@vger.kernel.org,
        hao.wu@intel.com, i.bornyakov@metrotek.ru,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdf@kernel.org, robh+dt@kernel.org,
        system@metrotek.ru, trix@redhat.com
Subject: Re: [PATCH v3 1/2] MAINTAINERS: update Microchip MPF FPGA reviewers
Message-ID: <ZFYknSDsJBp2vG7s@yilunxu-OptiPlex-7050>
References: <ZFOYQgA6TYa8hCjS@yilunxu-OptiPlex-7050>
 <20230504102524.314791-1-v.georgiev@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504102524.314791-1-v.georgiev@metrotek.ru>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-05-04 at 13:25:24 +0300, Vladimir Georgiev wrote:
> Hi Xu!
> 
> Acked-by: Vladimir Georgiev <v.georgiev@metrotek.ru>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Sent pull request for this series.
> 
