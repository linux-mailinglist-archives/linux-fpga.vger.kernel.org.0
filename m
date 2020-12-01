Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CA22C9683
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Dec 2020 05:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgLAEcP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 Nov 2020 23:32:15 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:33629 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgLAEcP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 30 Nov 2020 23:32:15 -0500
Received: by mail-pf1-f181.google.com with SMTP id q10so300147pfn.0;
        Mon, 30 Nov 2020 20:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=84Tg8uiKN95ramw8NrHzt8BxsdoLNIhvujq3io+5ygo=;
        b=cIsWHfEHePjqP4qbvE0nVx/+tEIoouAXzW14kxl+eJLsneN2fO9Oiy3OtISvOa6CvD
         7hyQacJ+CL9Vf7p9OUqN5lQjX9Kop6xA9ICXTQVWidgypSSvsJuolbDLIs+jzWc4NqYD
         t2DANEm2YOymX5gSAHzMBRM6TtEEsjS0nufJQfDZBOUfcRSda8cWwPV0Df1zUqky23PG
         DNvsovnGEXnLm4OjAoheSWr1aHFxR5EjYEvSQpTMvyGJh8F3Ng5UtU5T3rH/Kj9q3LsE
         3RngIceZlWamiBryNIetj55ZgmeUNml4OqbwonmJB08u+SmxDg2T/O8eBJ/I/tOXB2VE
         7h3g==
X-Gm-Message-State: AOAM533B9hUh0z7mKRxolc6NzymcQ3WKvXtsl5rU34Io+0MXv4cWFNmB
        IFR1lGjxJjF7tFKTJ7Y2jkc=
X-Google-Smtp-Source: ABdhPJwXXaaOam9JtfHoFPreYDYtGm8rqE02qfv/8UM5KN8ZeWOtjP9UdemKdTI/hz+2m8dzRsf0/g==
X-Received: by 2002:a63:f308:: with SMTP id l8mr739602pgh.68.1606797094669;
        Mon, 30 Nov 2020 20:31:34 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id 126sm61999pgg.46.2020.11.30.20.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 20:31:33 -0800 (PST)
Date:   Mon, 30 Nov 2020 20:31:34 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, gregkh@linuxfoundation.org,
        trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        sridhar.rajagopal@intel.com, richard.gong@intel.com
Subject: Re: [PATCHv2 1/5] firmware: stratix10-svc: add
 COMMAND_AUTHENTICATE_BITSTREAM flag
Message-ID: <X8XHJimPDaE/lNx0@archbook>
References: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
 <1605709753-7800-2-git-send-email-richard.gong@linux.intel.com>
 <X7U+BTkW7ZmsMByV@epycbox.lan>
 <d8b58b40-63c6-115e-8e61-f092e3f050b3@linux.intel.com>
 <X7m6gy/B8DiafyYQ@archbook>
 <771ba4f4-59e1-74b0-ba55-3f65914e2bc7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <771ba4f4-59e1-74b0-ba55-3f65914e2bc7@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Richard,

On Mon, Nov 30, 2020 at 12:55:44PM -0600, Richard Gong wrote:
> 
> Hi Moritz,
> 
> Sorry for late reply, I was out last week.

No worries, usually I'm late with replies ;-)
> 
> On 11/21/20 7:10 PM, Moritz Fischer wrote:
> > Richard,
> > 
> > On Wed, Nov 18, 2020 at 12:16:09PM -0600, Richard Gong wrote:
> > 
> > > > > -#define COMMAND_RECONFIG_FLAG_PARTIAL	1
> > > > > +#define COMMAND_RECONFIG_FLAG_PARTIAL	0
> > > > > +#define COMMAND_AUTHENTICATE_BITSTREAM	1
> > > > 
> > > > Can you explain how this commit by itself doesn't break things?
> > > > 
> > > > Before this change firmware expected BIT(0) to be set for partial
> > > > reconfiguration, now BIT(0) suddenly means authentication? How doest his
> > > > work? :)
> > > >   > Was there a firmware version change? Did this never work before?
> > > > 
> > > > If this is version depenedent for firmware, then this might need a
> > > > different compatible string / id / some form of probing?
> > > > 
> > > > Entirely possible that I'm missing something, but it doesn't *seem*
> > > > right.
> > > 
> > > It did work before.
> > > 
> > > Before this change, firmware only checks if the received flag value is zero.
> > > If the value is zero, it preforms full reconfiguration. Otherwise it does
> > > partial reconfiguration.
> > > 
> > > To support bitstream authentication feature, firmware is updated to check
> > > the received flag value as below:
> > > 	0	--- full reconfiguration
> > > 	BIT(0) 	--- partial reconfiguration
> > > 	BIT(1) 	--- bitstream authentication
> > 
> > So there are two different versions of firmware involved that behave
> > differently?
> > 
> > Old firmware:
> > - ctype.flags  = 0x0 -> Full reconfig
> > - ctype.flags != 0 -> Partial reconfig
> > 
> > New firmware:
> > - ctype.flags = 0x0 -> Full reconfig
> > - ctype.flags = 0x1 -> Partial reconfig
> > - ctype.flags = 0x2 -> Authenticate
> > 
> > Old software:
> > - Send 0x0 for Full
> > - Send 0x1 for Partial
> > 
> > New software:
> > - Send 0x0 for Full
> > - Send 0x1 for Partial
> > - Send 0x2 for Auth
> > 
> > If I send request for authentication BIT(1) (new software) to old
> > firmware it'd try and attempt a partial reconfiguration with the data I
> > send? Is that safe?
> > 
> 
> Yes, it is possible and it is not safe. But we will inform our customers
> they should update to the latest firmware (SDM firmware and ATF) if they
> want to have authentication feature.
> 
> We are migrating boot loader boot flow to the new ATF boot flow, which is
> SDM firmware -> SPL -> ATF -> U-boot proper -> Linux. The new authentication
> feature is supported only in the new ATF boot flow. ATF communicates with
> SDM firmware via mailbox, and SDM firmware performs the actual full/partial
> reconfiguration and bitstream authentication. ATF sets up EL3 environment
> and initializes PSCI services.

Can U-Boot determine whether it's the new or old flow? Can you set a
different compatible value in your device-tree, to disambiguate
behaviors?

> The old boot flow is SDM firmware -> SPL -> U-boot proper -> Linux, which
> SPL/U-boot handles PSCI services and communicates with SDM firmware via
> mailbox. SDM firmware performs the actual full/partial reconfiguration.
> 
> ATF = Arm Trust Firmware, SDM = Secure Device Manager
> 
> > Is there a way for software to figure out the firmware version and do
> > the right thing?
> 
> It is not feasible for kernel driver to get the firmware version per current
> designs and implementations. I don't think there is other way around this.
> 
> > 
> > > Therefore I have updated the command flag setting at Intel service layer
> > > driver to align with firmware.
> > > 
> > > Regards,
> > > Richard
> > > 
> > > > >    /**
> > > > >     * Timeout settings for service clients:
> > > > > -- 
> > > > > 2.7.4
> > > > > 
> > > > 
> > > > Cheers,
> > > > Moritz
> > > > 
> > 
> > Thanks,
> > Moritz
> > 
> Regards,
> Richard

Thanks,
Moritz
