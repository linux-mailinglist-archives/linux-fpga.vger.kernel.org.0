Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025132BC2F2
	for <lists+linux-fpga@lfdr.de>; Sun, 22 Nov 2020 02:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgKVBKa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 21 Nov 2020 20:10:30 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:35310 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgKVBKa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 21 Nov 2020 20:10:30 -0500
Received: by mail-pl1-f172.google.com with SMTP id x15so6988355pll.2;
        Sat, 21 Nov 2020 17:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ae0calUOjvPkp6ha8pgWGw2TNcP0JKP+g/EOrJg9VdY=;
        b=R39etN//gqatwjd5x18mWLLjI7X6fivZ6Q35QMh7LRPT35n+FhuXYQBLAQZ9x/i14C
         T5gBDJecC6N2XFt7nkn00g05JDzesY+0WrYcHXJDmZahbl/oXh8B3xCc4xJs5y0d5y5J
         ifcjYjp7l2Ym3jiwnU4a+YkqHg9DX4uvI5RDMkrQ6OveWuQqIU3V5ezCN2IV5nEzpZiY
         k93KJrLW0K1F5wAjrh+VlAnLfvdJmVlpbNP/xYlOidEakFG5khNMkZEA9CHTlMC/qMuQ
         FAL7vLxut+EnTLgx2UGOyzCRMniwfiSyT884ZNjIEzkKPh3WHQfbzVEgflG9Kb9eC59T
         Ri2w==
X-Gm-Message-State: AOAM531/s+EMWuAol03s5TH6Et0nOZuuWQ2+/fCBtNnJrTcGPAclKQ49
        Jq396Sq2dRklxlaD5dJVTAWgebrbxFDhXw==
X-Google-Smtp-Source: ABdhPJxNPX7NNKVKFOXP3cyH6wqv8vKHN7ZyoZICcmDm9iWuJFv17Hn1ZtW0CJO4oYWe1M4Z90qpZg==
X-Received: by 2002:a17:902:bc83:b029:d8:ec6e:5e0f with SMTP id bb3-20020a170902bc83b02900d8ec6e5e0fmr18133720plb.1.1606007429708;
        Sat, 21 Nov 2020 17:10:29 -0800 (PST)
Received: from localhost (c-73-235-149-126.hsd1.ca.comcast.net. [73.235.149.126])
        by smtp.gmail.com with ESMTPSA id k4sm8531850pjo.54.2020.11.21.17.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 17:10:28 -0800 (PST)
Date:   Sat, 21 Nov 2020 17:10:27 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, gregkh@linuxfoundation.org,
        trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        sridhar.rajagopal@intel.com, richard.gong@intel.com
Subject: Re: [PATCHv2 1/5] firmware: stratix10-svc: add
 COMMAND_AUTHENTICATE_BITSTREAM flag
Message-ID: <X7m6gy/B8DiafyYQ@archbook>
References: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
 <1605709753-7800-2-git-send-email-richard.gong@linux.intel.com>
 <X7U+BTkW7ZmsMByV@epycbox.lan>
 <d8b58b40-63c6-115e-8e61-f092e3f050b3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8b58b40-63c6-115e-8e61-f092e3f050b3@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Richard,

On Wed, Nov 18, 2020 at 12:16:09PM -0600, Richard Gong wrote:

> > > -#define COMMAND_RECONFIG_FLAG_PARTIAL	1
> > > +#define COMMAND_RECONFIG_FLAG_PARTIAL	0
> > > +#define COMMAND_AUTHENTICATE_BITSTREAM	1
> > 
> > Can you explain how this commit by itself doesn't break things?
> > 
> > Before this change firmware expected BIT(0) to be set for partial
> > reconfiguration, now BIT(0) suddenly means authentication? How doest his
> > work? :)
> >  > Was there a firmware version change? Did this never work before?
> > 
> > If this is version depenedent for firmware, then this might need a
> > different compatible string / id / some form of probing?
> > 
> > Entirely possible that I'm missing something, but it doesn't *seem*
> > right.
> 
> It did work before.
> 
> Before this change, firmware only checks if the received flag value is zero.
> If the value is zero, it preforms full reconfiguration. Otherwise it does
> partial reconfiguration.
> 
> To support bitstream authentication feature, firmware is updated to check
> the received flag value as below:
> 	0	--- full reconfiguration
> 	BIT(0) 	--- partial reconfiguration
> 	BIT(1) 	--- bitstream authentication

So there are two different versions of firmware involved that behave
differently? 

Old firmware:
- ctype.flags  = 0x0 -> Full reconfig
- ctype.flags != 0 -> Partial reconfig

New firmware:
- ctype.flags = 0x0 -> Full reconfig
- ctype.flags = 0x1 -> Partial reconfig
- ctype.flags = 0x2 -> Authenticate

Old software:
- Send 0x0 for Full
- Send 0x1 for Partial

New software:
- Send 0x0 for Full
- Send 0x1 for Partial
- Send 0x2 for Auth

If I send request for authentication BIT(1) (new software) to old
firmware it'd try and attempt a partial reconfiguration with the data I
send? Is that safe?

Is there a way for software to figure out the firmware version and do
the right thing?

> Therefore I have updated the command flag setting at Intel service layer
> driver to align with firmware.
> 
> Regards,
> Richard
> 
> > >   /**
> > >    * Timeout settings for service clients:
> > > -- 
> > > 2.7.4
> > > 
> > 
> > Cheers,
> > Moritz
> > 

Thanks,
Moritz
