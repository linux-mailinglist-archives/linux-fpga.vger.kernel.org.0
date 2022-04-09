Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349A04FA7E7
	for <lists+linux-fpga@lfdr.de>; Sat,  9 Apr 2022 15:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiDINB3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 9 Apr 2022 09:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiDINB2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 9 Apr 2022 09:01:28 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF9455BC;
        Sat,  9 Apr 2022 05:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=MmsrU07PgLUD8XKlGAlPmaXdI+yyXvNNcYAukLrx62Y=;
        b=CEI2hXzSPqnIcufESjduzwbYlCeHlDyPUTHL3FWC7B1OvItyXEclcgmIXLx9vpVt+N1DhLe2vbRWE
         KPv2Cv2gWs58Uacjv8iDViXf9vtOgLwpHGBXnuF6OY2I2wZv91aU+5balZe5ZuLHBL3DBUJGdNBfwn
         p4ltj6MAQDWVko0oCiW48L8cDvlPv5LMISSymSyt7OBxfmWnmLd9cZwVNstJ4Vc8U9bunmwHWU4MjN
         L2e3KD5WdNE4kPdVNn4g9aPQoxT7MvLwwAXFDt18PMzYDn9niG9w35jF78hfQKrlai009Eo9n30lZY
         WmRGeNmJrWKryzxvk9Rcd5g2uw4X54w==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.2.1410, Stamp: 3], Multi: [Enabled, t: (0.000008,0.008582)], BW: [Enabled, t: (0.000013,0.000001)], RTDA: [Enabled, t: (0.063684), Hit: No, Details: v2.34.0; Id: 15.52k78o.1g076fs5a.4ace; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([178.70.66.234])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Sat, 9 Apr 2022 15:58:51 +0300
Date:   Sat, 9 Apr 2022 15:38:51 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, system@metrotek.ru,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v9 1/3] fpga: fpga-mgr: support bitstream offset in image
 buffer
Message-ID: <20220409123851.tcjflctnuurag2yb@x260>
References: <20220407133658.15699-1-i.bornyakov@metrotek.ru>
 <20220407133658.15699-2-i.bornyakov@metrotek.ru>
 <20220409050423.GA265355@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409050423.GA265355@yilunxu-OptiPlex-7050>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Apr 09, 2022 at 01:04:23PM +0800, Xu Yilun wrote:
> On Thu, Apr 07, 2022 at 04:36:56PM +0300, Ivan Bornyakov wrote:
> > 
> > ... snip ...
> > 
> > @@ -148,12 +149,10 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
> >  	int ret;
> >  
> >  	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
> > -	if (!mgr->mops->initial_header_size)
> > -		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
> > -	else
> > -		ret = fpga_mgr_write_init(
> > -		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
> > +	if (mgr->mops->initial_header_size)
> > +		count = min(mgr->mops->initial_header_size, count);
> >  
> > +	ret = fpga_mgr_write_init(mgr, info, buf, count);
> 
> Here we pass the whole buffer for write_init(). Maybe it works for mapped buf,
> but still doesn't work for sg buf.
> 
> It is also inefficient if we change to map and copy all sg buffers just for
> write_init().
> 
> We could discuss on the solution.
> 
> My quick mind is we introduce an optional fpga_manager_ops.parse_header()
> callback, and a header_size (dynamic header size) field in
> fpga_image_info. FPGA core starts with mapping a buf of initial_header_size
> for parse_header(), let the drivers decide the dynamic header_size.
> 
> The parse_header() could be called several times with updated dynamic
> header_size, if drivers doesn't get enough buffer for final decision and
> return -EAGAIN.
> 
> Then write_init() be called with the final dynamic header size.
> 
> For mapped buffer, just passing the whole buffer for write_init() is
> fine.
> 

Ok, that's sounds reasonable. Should we pass PAGE_SIZE of a buffer to
the parse_header() if initial_header_size is not set? The other option
would be to make initial_header_size to be mandatory for usage of
parse_header().

> > 
> > ... snip ...
> > 
> > @@ -98,6 +101,8 @@ struct fpga_image_info {
> >  	struct sg_table *sgt;
> >  	const char *buf;
> >  	size_t count;
> > +	size_t bitstream_start;
> 
> How about we name it header_size?
> 
> > +	size_t bitstream_size;
> 
> And how about data_size?
> 

Sure, I don't mind.

