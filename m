Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69089536C49
	for <lists+linux-fpga@lfdr.de>; Sat, 28 May 2022 12:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiE1KP7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 May 2022 06:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiE1KP7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 28 May 2022 06:15:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F9B3A4;
        Sat, 28 May 2022 03:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653732958; x=1685268958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M97Hv4CQJ0ZWSyycwTVohvtTA7AthiCJJEilnH5zTtA=;
  b=daTYLFGuB3U1oOcPUph4xn0pX9pUvYLSx1wDC6sLya1uhba0576IFieg
   NWjDSNwLCvKyPPwQ4f/3hsOqoP/7rgNq1IrOPTtS+Uu0Npqabxa8OX887
   fMHEf/9KPS9IoTpq+1iJFLt/cFzQzW9E/ePdn/V3usLcB5m6T/aVHKcMn
   dbGEKFNoNHOdpED7jnr6lmOITsGaxdlrBI0U30jHRKaPZCkFm+8gS8GQ2
   gljrRMJ0yJhvzpLGzNmaKn6wyj2aWI0HfuyPg78J+M4vad/BVJSQQg7l6
   5AqScTsKSdTDPFNhomK3idgMlRREaq0n+ICI7TmVu6hfwEF0SSpy/Q/pg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274755380"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="274755380"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 03:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="719230808"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga001.fm.intel.com with ESMTP; 28 May 2022 03:15:56 -0700
Date:   Sat, 28 May 2022 18:08:13 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     tien.sung.ang@intel.com
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-cvp: Truncated bitstream error support
Message-ID: <20220528100813.GE175008@yilunxu-OptiPlex-7050>
References: <6939d35f-36a0-568e-bfec-4dd2e3a48604@wanadoo.fr>
 <20220519042135.2805176-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519042135.2805176-1-tien.sung.ang@intel.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 19, 2022 at 12:21:35PM +0800, tien.sung.ang@intel.com wrote:
> Thanks for pointing that out. It is always good to get all the alignments right.

Please run checkpatch --strict before sending, it helps find out most of
alignment issues.

Thanks,
Yilun

> I will add this to the next revision of the patch.
