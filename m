Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E110874CF84
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 10:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjGJIIC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 04:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjGJIIB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 04:08:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35434DD;
        Mon, 10 Jul 2023 01:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688976480; x=1720512480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LlIZw9MpGq3jD3Z04SjzPhTzRIs2rY3qx4aEIfF/oVk=;
  b=FLhMWuh7U13cEXQ8sCK3uaBydPTtx07rvB0HA5a8gXVabvDVBzJsj2ly
   QnsrH8TMgVhvTMd4SqX5IHdzMsjLrxubH7Sw4/krtFy6xz1NAjR1gzkBd
   XTnMxfzazKiyS3aube2pim8kCjRU6Qvqpx8p5lJbWDTczPDi9sP7MJC15
   jjMtypRRiRT0KCPXBuP9RYbO6ytfJLXx46GZkXZ4KbunK/nzp/qu3mdWV
   XQUB13FBHiQcAB8amylKZsWV/J8BaNlqgmAwJkduWoed7EraDEP2AHXle
   VXuwM4UROzn9+HIB9DyR/UmbIOsnmSoWeVQaCtobKdJWxhD/vOqfkLW99
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="343875281"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="343875281"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 01:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="786066201"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="786066201"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jul 2023 01:07:57 -0700
Date:   Mon, 10 Jul 2023 16:06:30 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] fpga: bridge: fix kernel-doc
Message-ID: <ZKu8BkQZAvAfZbSE@yilunxu-OptiPlex-7050>
References: <20230706142755.124879-1-marpagan@redhat.com>
 <20230706142755.124879-3-marpagan@redhat.com>
 <a3da8412-2e13-6b25-346b-da53414f5dba@infradead.org>
 <b3ef657d-22a9-a52f-821e-55fc5faf1ca5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ef657d-22a9-a52f-821e-55fc5faf1ca5@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-07-07 at 10:50:16 +0200, Marco Pagani wrote:
> 
> 
> On 2023-07-06 23:35, Randy Dunlap wrote:
> > HI--
> > 
> > On 7/6/23 07:27, Marco Pagani wrote:
> >> Fix the following warnings issued by the kernel-doc script:
> >>
> >> drivers/fpga/fpga-bridge.c:99: warning: No description found for return value of 'of_fpga_bridge_get'
> >> drivers/fpga/fpga-bridge.c:163: warning: No description found for return value of 'fpga_bridges_enable'
> >> drivers/fpga/fpga-bridge.c:187: warning: No description found for return value of 'fpga_bridges_disable'
> >> drivers/fpga/fpga-bridge.c:238: warning: No description found for return value of 'of_fpga_bridge_get_to_list'
> >> drivers/fpga/fpga-bridge.c:268: warning: No description found for return value of 'fpga_bridge_get_to_list'
> >>
> >> - Extend the return description of of_fpga_bridge_get() to include the
> >>   case when try_module_get() fails.
> >>
> >> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> >> ---
> >>  drivers/fpga/fpga-bridge.c | 23 ++++++++++++-----------
> >>  1 file changed, 12 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> >> index a6c25dee9cc1..0b76c67c50e5 100644
> >> --- a/drivers/fpga/fpga-bridge.c
> >> +++ b/drivers/fpga/fpga-bridge.c
> >> @@ -87,12 +87,13 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
> >>  /**
> >>   * of_fpga_bridge_get - get an exclusive reference to an fpga bridge
> >>   *
> >> - * @np: node pointer of an FPGA bridge
> >> - * @info: fpga image specific information
> >> + * @np: node pointer of an FPGA bridge.
> >> + * @info: fpga image specific information.
> > 
> > Those are not sentences. There is no reason that a period ('.') is needed
> > to end those lines. OTOH, the maintainers can do as they like with it.
> > 
> > The rest looks good. Thanks.
> > 
> > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> I added a period at the end of each argument description to follow
> the style recommended in the "Function documentation" section of the
> kernel-doc documentation.

I'm OK with them.

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.

> 
> Thanks,
> Marco
> 
> [...]
> 
