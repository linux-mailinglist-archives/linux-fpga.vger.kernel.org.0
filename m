Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE4E20FBF1
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Jun 2020 20:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgF3SoZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Jun 2020 14:44:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43508 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726122AbgF3SoY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Jun 2020 14:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593542663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PedFDc2DtQMOIGWMojnCcvUFPVJqYYNEpNxS2Hp4sso=;
        b=EFn8cT6dDaB6Uu63xxx2rR0V6V0oMUUl/Q2avEONN2SOaiURSpg0M52NlFF1q1SEqc5OhM
        i91LWo3HUVf4OxUkCs31Dfnr2TSlaAJ3ogV+mngCNmCN9WyHuQh6fFROcoMRs3N6RpPdKf
        rX0bp42upZ9UwDQeeInrhmfXXtBogyk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-axgPZrYNNjCCe82wlREZSw-1; Tue, 30 Jun 2020 14:44:20 -0400
X-MC-Unique: axgPZrYNNjCCe82wlREZSw-1
Received: by mail-qk1-f197.google.com with SMTP id q192so5015675qka.13
        for <linux-fpga@vger.kernel.org>; Tue, 30 Jun 2020 11:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PedFDc2DtQMOIGWMojnCcvUFPVJqYYNEpNxS2Hp4sso=;
        b=R65sPM517X6d/vc0yDGHb/tkT6Ff8XC/nEHd5IZkfjzGPaN5YZBASNp26eZ91Zyc15
         gdvHHWgUyvtj/QN+Ye2szAQ92OKAzuXVDUvL6yNWuvbedvfp3EJLYHmCaoBeMYfyka9y
         CV0MOYgjslDTh8h4D3lplvXjx6vWsim8rhE3dgBIZ9/vUcufQAe4TP76Q19vBh0G9XOu
         o5tLonqmoX814Gaoa9CXfKbdp9wtrIYh3Ml6LHqt03YKPodYYvwJSO2GGRS5is8A4VjU
         pqb5SdYFkWkV0OYBXaTDC4o451fwJ9K4VWZMuCKpogw2TAUWeEyY9oFg07lAqvvhuH5W
         4haw==
X-Gm-Message-State: AOAM530s4Nk8fmzrdR1BtSSgTmjLJx8VSiq2HOLHXbuBDBs5h17THDVy
        8v0wwSTbVRNzF3yidTt4r6NG30WyxVZSr4pF4WzwjoZMlbVP66RCOpv6YQ5hqBgPY7O0DFxHIQU
        tzOhhIWf89uLsUpP9Z8y62Q==
X-Received: by 2002:a37:a14c:: with SMTP id k73mr21323498qke.145.1593542659929;
        Tue, 30 Jun 2020 11:44:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwBx2LZuulFWLqg/mQP1Ihml2J1c5LqD4NJxngK+OBmKCXx8SAyvZunhLXcfXhUVrRNoRbpA==
X-Received: by 2002:a37:a14c:: with SMTP id k73mr21323479qke.145.1593542659736;
        Tue, 30 Jun 2020 11:44:19 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a11sm3208689qkh.103.2020.06.30.11.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 11:44:18 -0700 (PDT)
Subject: Re: [RFC 1/1] fpga: dfl: RFC PCI config
To:     Randy Dunlap <rdunlap@infradead.org>, hao.wu@intel.com,
        mdf@kernel.org, corbet@lwn.net
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200630171656.20151-1-trix@redhat.com>
 <20200630171656.20151-2-trix@redhat.com>
 <67f7f2b8-3567-aadd-30d6-4cfbc0bc8ce5@infradead.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <78a250ab-29ad-f7cb-3fa2-482e76db207a@redhat.com>
Date:   Tue, 30 Jun 2020 11:44:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <67f7f2b8-3567-aadd-30d6-4cfbc0bc8ce5@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> I haven't tested this, but in general it's not safe to select something like
> SENSORS* or HWMON* unless you first check that CONFIG_HWMON is enabled.
> Otherwise this would usually cause kconfig warning(s).
>
> But don't add things like
> 	select HWMON
> 	select SPI
> 	select SPI_MASTER
>
> because we don't enable subsystems (like HWMON or SPI) just inside one
> driver's kconfig entry.
> The driver(s) should instead depend on HWMON, SPI, SPI_MASTER etc.

Yes, I thought this was ugly. The next rev addresses this issue.  The config will not be fully automagic.  User will have enough information in the doc to figure out the other subsystems.  

Tom

