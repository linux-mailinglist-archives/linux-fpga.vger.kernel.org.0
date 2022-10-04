Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A205F3F38
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Oct 2022 11:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJDJJG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Oct 2022 05:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiJDJJG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Oct 2022 05:09:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3143B727
        for <linux-fpga@vger.kernel.org>; Tue,  4 Oct 2022 02:09:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id au23so6697351ejc.1
        for <linux-fpga@vger.kernel.org>; Tue, 04 Oct 2022 02:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=n/6ufHY3+Unch2cb/Xa3hY3trBvhdaF/Jg9R5VUX6kM=;
        b=qayNwaSS2rhTQkNcuXT4baqjFvq1jqeCuThLB/PydEWdLV0EDNOSfTWVSswwxJD5Fu
         PlTVC0gmPyVlEHxyOuaG6NJy2cAnH/++XSnbNfHSYLQVchanYd/u+j07HEOATgf6sVuZ
         2NBRjKwdEG+DMCW0E9PaxFjvkhKdnpoom4JPw1sYMqRM9dc40UiCCCnBlAe+9YiazVJ0
         5KKjYbc2HJWY6AJGczLjMHrUy48cukkR460jwow1eW7Ax8+8v2GiJyJ9qA/g/v/trNY3
         L/Ce9ZrY3JHsOVOFRicXJch1NcUmsMkn1yDUpF6udsABnYKvR7aFirCEkG+dp7jtE7Xj
         IHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=n/6ufHY3+Unch2cb/Xa3hY3trBvhdaF/Jg9R5VUX6kM=;
        b=INndHp/0hxa9fMQ9HxnHp3jphPV/mx4oobeiCISYuk0lDw5+7BwiuG8k7OYHgnqqzH
         V3G4/BYC/Wh09ki5b6Egqydar/CMC2sWQH+RelU+4jbmdX2duiKVNEQD64P0w4YlMkCr
         ioYWAR6pIkJWh7c/k2Q3al+NbpAO+deAQtuvUf4ri7lvET6Upl/qMkOt6yZdvnBP9sll
         rWRbomy0p1uFc7Z+vp1B8RBFtSq0JBlX0WKAcBL/HbtNzHtrOa5izm/X1YE3tD7/WAd+
         5NcChcHDxuO6cXjUjxtycjiReyUoIuhI5HTZtbTvTzXFhV8aNl0eoSCD9eQk62LiUYRe
         jh2g==
X-Gm-Message-State: ACrzQf3G88m4NjItsJLy65bqel/xmDL7CfCY0xD9P4JI2JcyOjn/FW4z
        4jx84T8fhVRIAIhT4zzylduxH918yKR+roVN/A==
X-Google-Smtp-Source: AMsMyM4pvcU/yGcVWqHiRqNBNnTPbQysrJAub2eYyLK7qKOIaoYaknNkJyvPjIL/0tM93D1TThqtT50doMFac9420Ck=
X-Received: by 2002:a17:907:160d:b0:782:9631:c198 with SMTP id
 hb13-20020a170907160d00b007829631c198mr18229810ejc.520.1664874541912; Tue, 04
 Oct 2022 02:09:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:b0c8:b0:778:4897:b84f with HTTP; Tue, 4 Oct 2022
 02:09:01 -0700 (PDT)
From:   Ajafor Simon <simonajafor1@gmail.com>
Date:   Tue, 4 Oct 2022 09:09:01 +0000
Message-ID: <CAMW7OR4ZtTYAjyfXZyGz=q=+veyyycK=cZxbf96ScfYAcu9kow@mail.gmail.com>
Subject: =?UTF-8?B?VGjDom4sIE5ndXnDqm4=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

VGjDom4sIE5ndXnDqm4NCg0KQ2jDumMgbeG7mXQgbmfDoHkgdOG7kXQgbMOgbmgsIHTDtGkgbMOg
IEx14bqtdCBzxrAgU2ltb24gQWphIMSQ4buRaSB24bubaSBt4buZdCBuZ8aw4budaQ0KaMOgbmgg
bmdo4buBIHBow6FwIGzDvSDhu58gTG9tZSBUb2dvIFTDonkgUGhpLCBt4buZdCBsdeG6rXQgc8aw
IHJpw6puZyBjaG8NCkVuZ3IuR2VvcmdlIE5ndXnhu4VuLCBuZ8aw4budaSB04burbmcgbMOgbSB2
aeG7h2MgduG7m2kgY8O0bmcgdHkgcGjDoXQgdHJp4buDbiB24buPIOG7nw0KTG9tZSBUb2dvIHTD
onkgUGhpIHbhu5tpIHTGsCBjw6FjaCBsw6AgbmjDoCB0aOG6p3UgdsOgIGjDoG5nIGjDs2Ega2hv
YW4gZOG6p3UgVsOgbw0KbmfDoHkgMjEgdGjDoW5nIDExIG7Eg20gMjAyMCwgw7RuZyBxdWEgxJHh
u51pIGPhu6dhIG3hu5l0IGPGoW4gxJFhdSB0aW0gc2F1IGtoaSB24bujDQp2w6AgY29uIGfDoWkg
ZHV5IG5o4bqldCBj4bunYSDDtG5nIGNo4bq/dCB2w6wgQ292aWQtMTkg4bufIEhvYSBL4buzOw0K
DQpL4buDIHThu6sgxJHDsywgdMO0aSDEkcOjIGjhu49pIMSR4bqhaSBz4bupIHF1w6FuIGPhu6dh
IGLhuqFuIOG7nyDEkcOieSDhu58gVG9nbyDEkeG7gyB0w6xtIGLhuqV0IGvhu7MNCm5nxrDhu51p
IHRow6JuIG7DoG8gY+G7p2Ega2jDoWNoIGjDoG5nIGPhu6dhIHTDtGkuIMSQaeG7gXUgbsOgeSBj
xaluZyDEkcOjIMSRxrDhu6NjIGNo4bupbmcNCm1pbmggbMOgIGtow7RuZyB0aMOgbmggY8O0bmcg
dsOgIGLDonkgZ2nhu50gdMO0aSDEkcOjIGxpw6puIGjhu4cgduG7m2kgYuG6oW4gxJHhu4MgaOG7
lyB0cuG7ow0KaOG7k2kgaMawxqFuZyBxdeG7uSB0cuG7iyBnacOhIDEyLDUgdHJp4buHdSDEkcO0
IGxhIE3hu7kgZG8ga2jDoWNoIGjDoG5nIHF1w6EgY+G7kSBj4bunYSB0w7RpDQrEkeG7gyBs4bqh
aS4NCsSQ4bujaSB0aW4gdOG7qyBi4bqhbiBz4bubbQ0KDQpUcsOibiB0cuG7jW5nLg0KTHXhuq10
IHPGsCBTaW1vbiBBamFmb3IgKEVTUSkNCkxvbWUgVG9nbyB0w6J5IFBoaQ0K
