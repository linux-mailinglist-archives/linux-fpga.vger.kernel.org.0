Return-Path: <linux-fpga+bounces-1406-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F26C2EEC2
	for <lists+linux-fpga@lfdr.de>; Tue, 04 Nov 2025 03:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 946B64E18D8
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Nov 2025 02:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2286023C50F;
	Tue,  4 Nov 2025 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="vnkDKXsA"
X-Original-To: linux-fpga@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011001.outbound.protection.outlook.com [40.93.194.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB89723A99E;
	Tue,  4 Nov 2025 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222347; cv=fail; b=gpKPZstSdA80ajqvcYoswtvBo+fBeUfmjajNCeCKH3U3nd1IEBDwmBWkegHMomyl+5wuAHqhOjx2GL/MqtsYMme0sDTig1FpGlgYQzxT0Bd4ZNCnavXKHVQJQUvFLWeBRwKKEzG357KtGIceET0mjYurLJ/xZwCm3RYOiNq48Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222347; c=relaxed/simple;
	bh=9vtmtMv81LdlkPvSWLgeXtjtEFL4NGz5HqSz3qN+f38=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M+04ywLWXkHhqIR57E8INcCRo+7Pe5cG1psrfQ/D9ccHJNszyz2YhbZZaNMqBt9sUy3b8jKN30gkqpSoq62t2ZHdQIGiAXbfjUXBom1axpubtBdK7EkW322QOZLuNn5dFLHApizgqIPWyk7iamlGA3/m35ZoZWQDS8/moJ7Hkr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=vnkDKXsA; arc=fail smtp.client-ip=40.93.194.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G36fxcviTVSMMEQa+OTA8fwvh09Q96GZ3O5bxbM7Cm6llISj7rjTTH96Lm5fifbskfkcVxYoVKRC9Kb828smVIA5en8IYL0drZpDBQYym3DWiJptT3ESLlbmh+bvagdNJi55fN2mEVMa99Jr/P6CQ7HOZwPi7LWXkyD6cjMRUzqUL+Dc/cKELyMaDi4qGs7aeE9N90GMn+6BsBtQb/wxv6+nfG5WEWWhNJ2Y5XYhJNyBjvz6x6yF3SeBlUt7hz8yHG1oTvpqQXUzZEPSQimt6Qqp1USufDM0BtxLWlHVyd8A8RtnHaJkMjpQvgkoWNipyoGrIWUBI3D+thLi6CkXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Sszfzmfgxqy0nDhcl1e/nLrWq70fbDV6nupeaeCUDE=;
 b=R/NXbarqt8fulwgCU2pBNSoo3aCtojnkTlOccM/OMRL6ZayUTkcCWrllciHfPhd4lK1GLcq7iCZj7Zcd3umIGHGUai0pz3lOM06g1mBF/co9p5U9k6JMJoRfgy6qZZOxibBWxWVbqB+AVEfXaIatdhv/r4IpvqrjyWW4m7A/r9BCajBYzyelY8nnVVssWMs5ATVYjzHNXWGyytY7wevGMc3kyCLLh4ELcXVZ05scj3vvISZBAwzOMaObh9QaInSQUpqtegtNLnI9z+90CwVY+TOwSqjfCysz/DUeWme2y7JMAlIJ7KrVhE7BSqQnA76S3FqCsQRvUd35LN8iP2u1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Sszfzmfgxqy0nDhcl1e/nLrWq70fbDV6nupeaeCUDE=;
 b=vnkDKXsAA201LRG43jVsbiF1AbjXzZeSnBupw+lxrpSepNEdBbBcMwTAjIxOt0OdCdR9QLc1w2VjWfVOxQrIMpIdwkbm3BlF+Pnd7Wg7A1Y4peuA+V5ibhNIgKBRvzKtS6Be9SUmq/dvH/9iadpYz6AYgjHIW0GqCReW9tap/sepSxgN6BghkvFmJVrng8Z/LtLnrjfndcCHxrdmmsX0aBk6wIekcL+5i7CxJUg0w5WQcd9W2HdrzCTsXkJ6ehvHU0xS/yBsY9aw3ghno6A5+EfR3yGG0vd6u5pByA342+4alPRVj0rv0/F/+jA3N6g4ddYi0DCCATvFPe0gZNq98A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB5893.namprd03.prod.outlook.com (2603:10b6:510:32::6)
 by DS2PR03MB8369.namprd03.prod.outlook.com (2603:10b6:8:331::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 02:12:23 +0000
Received: from PH0PR03MB5893.namprd03.prod.outlook.com
 ([fe80::d003:bc08:7968:c605]) by PH0PR03MB5893.namprd03.prod.outlook.com
 ([fe80::d003:bc08:7968:c605%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 02:12:23 +0000
From: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@altera.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@altera.com>
Subject: [PATCH 1/1] fpga: altera-cvp: Add support for truncated bitstream error handling
Date: Tue,  4 Nov 2025 10:10:13 +0800
Message-Id: <68c08c9f6b1c5aab8ef4971724243b176a7d44d4.1761804232.git.kuhanh.murugasen.krishnan@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1761804232.git.kuhanh.murugasen.krishnan@altera.com>
References: <cover.1761804232.git.kuhanh.murugasen.krishnan@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0031.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::14) To PH0PR03MB5893.namprd03.prod.outlook.com
 (2603:10b6:510:32::6)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB5893:EE_|DS2PR03MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 384e9111-263e-47a4-a530-08de1b479755
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uk5VdzUvT0hXZDVCZjNUQ0RkWCt3ck5LZXZnVVBlbmxSdXFPT3EwY1lUQW1p?=
 =?utf-8?B?SDdEeHRyNEF6dVhHUWk3N0ZKbSttb2IxT1VXc3VyYXNWTzFJWUFwdEdVbmdD?=
 =?utf-8?B?WmZ0eXBENkNOdXl6VDJreHNtWHRDNmZMdFpwdGUyb3N0dkptOVYvYjUzdzZj?=
 =?utf-8?B?K2VpNkFGUFZiZGI0SGlHd2R1NGRBTDJCTklKOWdpQ2JyeFJKbUl3RTNnUGFR?=
 =?utf-8?B?RE8zbTd5cE1Fb1ZVUHMxMG1aTzdZT2hGYmY5UDcvRUdIVFNkY2RzMDBVTllG?=
 =?utf-8?B?RlBZZVMrZ2FpY1BOMHAwL1R1SjZyby8rV0pSOFM3NzhIdU55MUhyOTArZC8z?=
 =?utf-8?B?c001RzVVMmgzc0lTNFRrY0lreGx2eHJrTU1SK0NMZ2U0eVhRMVdJUmY0VlNJ?=
 =?utf-8?B?VWkxekw5Wm9neUpUUVo5MnBLMU5yaEJMS2dqUFBHbzBOZmdKQ01YV01WYWto?=
 =?utf-8?B?NTljT2Y0b0t5d0NzckFOS2hhZnhUZDNUeklDNllIenhtNnhRMEZyR3NBNWNS?=
 =?utf-8?B?ZVRhNGQxQkw3aEtvOHFORnU3WndsWG9DdS9xQTRBNVBwMjRXellqT2lwcjJu?=
 =?utf-8?B?alFZVkE2L0xQM3ZUS1N0eEJEcUczaEZDT0p6YmF6YVI1SFEvV1RWdFg4L3JZ?=
 =?utf-8?B?NDhVTDcxTWNORHAzV0s4ZlptSi91UFUvY3RKdlNaaVNBQWdwbC9lNndKWkY2?=
 =?utf-8?B?L0JXaTZqM1g3TkJsNUlJbnFGMGlDWlg1MGI3L0o2Z3VCVER0VXZvbkFKUkMw?=
 =?utf-8?B?ZVdsNS81V0I1S0xzdGZXdk9JUkd0Q29idHlLV3MyZXR5ZFNpYlE2SVdrUG9Z?=
 =?utf-8?B?MTUvZ2YwNkRWdzVBeVhqcTJCSkJaN2FVaEsxdHdXeFg4VjNLZTBlbkhtRjQ3?=
 =?utf-8?B?NU1nT2p6RDdKeVpVZ0hhbWVCdzNQVlJzdkgySHlWZ2hkdTJGMTVnSWFCQ3Vy?=
 =?utf-8?B?azJBcGllQjBPT0NTZjBlak84MmZ5WDNrQ2RjUFMxUEt4MEdhRnM1UjFKUzhE?=
 =?utf-8?B?REdubkJXYnBPeFpScHRZZnB3ZGMrQVpzQkQwOERzbEVxdE5ma1pPOTNzUHhD?=
 =?utf-8?B?NEovYS9oTURrbVoraHJtVCswa0VEZFFNYXk0S1dlek4zY01HSlllQTVtdHl4?=
 =?utf-8?B?Ky9NTDhzUEh4Y2FTblFoNG9SN1h4RW8vZDA5UU5XNWJ5VTlZQklITlJwOG0y?=
 =?utf-8?B?RU1HZlJ5Mnh0S0NJTHJiN0gyVG5UVjhHRDVjWSsvSDRkS2duTHZkMUg5Mkpu?=
 =?utf-8?B?STh0MFBUQnRKeDE4TFBWRUF4TWRTNnZBRnJDaDk5clVCZWo2NFNuOGdIZ09o?=
 =?utf-8?B?R0g3QjBzckpBc25lc0FsWWQwUWFpdS9KRmZlSk5YWU1lSE4zeGtETVZKaDl0?=
 =?utf-8?B?SXczbis0WitMdDJrNndCbEk4KzRkWTFXc1o5bkdoeTBWcHFuQk44TURPM0pR?=
 =?utf-8?B?M1NmWEtaWW1aOE5OUzhyWG5FbFNCN3doeWhqS095OGtNWGdUOGJHaHc5V2Va?=
 =?utf-8?B?UHErMjlNTXpxY1FtQklKa2VCSHVKck1mQjhJNEgvaHdML2RlZHpLdjBsUkt5?=
 =?utf-8?B?Sm13ajc1YlR2Ty9PcjFDSWs4Tlh3bDJZMmN1L2ZRbHFGMGRKMHdFSXlJZGc3?=
 =?utf-8?B?eWNQamlxdjNoRW9CT0VRSWJDelRiQ2lBODIwVEpFdU5WQWtvekFBZVJkTkF0?=
 =?utf-8?B?aURFUXZhU1NiM1JFZllIQkpjUmQ0b2NCVFhZd09UY0xKU2pvenlvVFlWRkIv?=
 =?utf-8?B?MVlteFFuMmYxVWxnQzNaOGVTbEc1K2NySkpPUUd2ZU53RVBKU2Z5eW9UNGhK?=
 =?utf-8?B?SVZSVnRZeVFNUEQyc1ZHVWQrNWZSak03dElkQnphOVhiN1cwSlpKSVNXWjlm?=
 =?utf-8?B?UVJPc1h2UXhFa2FDS2RjZjUxUDQ0b2psbVdOR3Y1MHhSMm1wNG1UZnBRMHZn?=
 =?utf-8?Q?UEPQPL/PebDVHmeU9BSG88ReNye5dERS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5893.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amhkMzhDRGtrejRNSE9qRktmRDNrbCs1N3ZUaW1xbnBnWXRacWkrNGZ5eFZQ?=
 =?utf-8?B?K2Z0RW55SzhDSHlxMEdOdGwvMjJtV3lOS0V6OVRicVVBY1M4NUkzWlVtaVZ2?=
 =?utf-8?B?WlJHWlR1OVlzM0h2MXVkd2ZPUEM0ZUZ5SWVZR1dXVTVoeWFBOHJVaGhrZktq?=
 =?utf-8?B?emNnOTNZTnhhclRhNVB4L2N4OWxlek5vSG9pRGlTaFRUZkF1Q3djWkp0VXNy?=
 =?utf-8?B?R1BpaXArT0FJZVFuSDhIUzhCT3JnVjdhNFdESWVrYnZta2pnU2xzdC9aTGlP?=
 =?utf-8?B?UkNqSVkxQjFLbEszYzdJdTYwQk52Y2J5YzJtU1p3QWJmMlhWS21WZlAzQ0JH?=
 =?utf-8?B?enZxcjByenN2REVwcmNPbGVvbmxPOGJzT2lobXJQY0w3OHZEZGNaT2V5MFNW?=
 =?utf-8?B?emFUVVlkcEZrSFphUHJ5em4wWUZZVlpQbG1kQUgxK2RTcWhINzh3TXA1V29O?=
 =?utf-8?B?RXBGamZEeGtkdENlUW43QVgydHZtaWJMelRwNXM0bENOTHlkTFVaSWU5ck5l?=
 =?utf-8?B?ZThGMGwvZXpDdktiSmhvRWp1QWgxWlJSK0VRVzBBY25meklUVy9CUGxMY3dF?=
 =?utf-8?B?UHZtKzZzaFE0Z0RhLzJSbW1IZjU5aFJERm5lbmhwMGN2WmZ1cVpXUStFRzZj?=
 =?utf-8?B?ZUVNVW5ha3V4cytLTkcrU1Y5cnBIOHFYVzR1Slo5VHpidDI3UStEU0U4VVdx?=
 =?utf-8?B?UFlVQnZZM3NRdkpaQlZhZ3lWSWZlQktpcm85cFBuZTIwSXZoRElUUVB4cGJz?=
 =?utf-8?B?NWVmc3EwbzhlN0REUUhSYlZTWHNNRjlveEU5cU16cExJUUtTcFE2ckxFMjRH?=
 =?utf-8?B?MUlka1BoTTZjNFhxSFlwdmxZU050eHJ3dzZsczNOcUxyRU9ndjEvVitPUjZN?=
 =?utf-8?B?YkMvWkVSR2RkS3hCVzdHekNVOUF1c1l1Sk9taUFTUGtEZEJRSDNHcUhxdmdx?=
 =?utf-8?B?Zmhidm45MGtlcktBcWJhQStBMkx6Q0wzV2RvTmZRQy9BeGlHdzIrZmJuajd3?=
 =?utf-8?B?cUtQbXBqeW1rNmVTVTZkVVpvWFA2aTlvWXZkajhBLzVxbGhQcmVLR3lHSjFs?=
 =?utf-8?B?ZWFJdURUZGxKRHg3VXlXei9wZllYNlp0L1JjZjd5bjNTSmtrYnBFUWx5bVBN?=
 =?utf-8?B?OVExOVRXS1U5RDdSVTBYRk1hZHNPdit6K0ZBTEtvL3djMzltM09FYzJUbEhC?=
 =?utf-8?B?V0NkNWFCWXpSeE8wdUgvSzJlYXlVZmRBMWJ5Sk1pSmpjTVI5aStaSVFWaEcr?=
 =?utf-8?B?UFhzNUtiU25yZmxhM21zWmNHRkc4Tld4Qncyc0JCWGZoUEFVNDdnb2h2aHFq?=
 =?utf-8?B?bm4wUmNvTXhiUmZwNWhkeWpWOFlwbVdDeDl5QWUxak1JRUpmZ0xZMjQxOVRC?=
 =?utf-8?B?aUlTYUxhTkxsSzViN3QrSkQ3YnI5R1BPRzhEOHFRK2hSWm40OGtVTkpEUFRH?=
 =?utf-8?B?Q0F5MkNnSkJzYWw5TkQ4RnNGek5uNXNvc2tJSTJwU2VDbEtEdlBnNnZya2xB?=
 =?utf-8?B?U2MvYW9yWlFCSkZaN0NzeXhkWlZQak5UcWI5TEFCVzk0ejdKbyswd3laWDlG?=
 =?utf-8?B?OE90TGxhYWZUOW5JbGovTDFwUGxvRUVQK2VJa0NDVUpaYkpKb1V4ZVRKUVVZ?=
 =?utf-8?B?L1R3VWlzd0pkcDZUOEk5a1QwSWpZaDZFaTNxUVJnVzBUOFA1K05YL2JWV0Nu?=
 =?utf-8?B?dmNMdFppMXcxSWpSQ20yTllYWCt5OEVBK3V1OTc3MEJ5emZVbzhvdERlalhZ?=
 =?utf-8?B?VVNPUVdGbmF0eXQrc3d4WTVGZXdSdGlsTjdoOWR6ZEdSbFdNaHhtaEdiTWpj?=
 =?utf-8?B?ZC9DZkF2WmtqSXgrYXI3Yk1Lb28yMk0rYS9JVTRwWElYaVZoRy9nUkRtUWtu?=
 =?utf-8?B?aC9aaWdzcTZaMHpWdWM5ZVd5ejJTZlJmb1dRYWN0UUsvVlMvdU9WVks3UFBB?=
 =?utf-8?B?blVLR2U2RUlTYzNvUmp6UWVJWmk5ZmVERkdZdkk0ZEZSWnpGS2RXUkpibEQr?=
 =?utf-8?B?Qm5sT0ZJTmsxTXdpWTZKaW01YUlNM0ZoQzR6WUFZU0xKWEd2akxZLzMwa1hN?=
 =?utf-8?B?RTRiZ21pREZiWmdaUnNEcFFFSkU5ekd2VXVZSGtqUU9UL2hrS0IxZzA0NGtq?=
 =?utf-8?B?Q3pvb0Y1Y3Nzc2lQU1RmeEMxMlZWVms1QTFyYmdLV2REdm5FZlhkYWM5Y1lT?=
 =?utf-8?Q?zN/1QR8IWADGGDJmLP9g/uM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384e9111-263e-47a4-a530-08de1b479755
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB5893.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 02:12:23.0491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyYeFAFOEo+ZkSewL/ymRTIRlS7lr+NYVoQHUKh9ucU+095r/H2c6JPSlgCY0+RwyDeAwkhLsHngrPklVbeAgULLtD9aC+0PCtKDtQfVT5bwrxJJzzlFiuAuzlV/9TsQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB8369

From: "Murugasen Krishnan, Kuhanh" <kuhanh.murugasen.krishnan@altera.com>

The Advanced Interface Bus (AIB) CvP firmware cannot handle bitstreams
smaller than 4096 bytes. When a truncated bitstream is sent, the
firmware’s DMA engine waits indefinitely for the remaining data,
causing the CvP transfer to hang and the configuration to fail.

To address this limitation, the driver now ensures that all transfers
are aligned to the 4096-byte block size by padding smaller bitstreams.
A dedicated 4096-byte transmit buffer (send_buf) is used to copy and
pad host data for each transaction. This guarantees that the firmware
always receives a full block.

Additionally, the driver now checks for CVP_CONFIG_ERROR in the CvP
status register at the end of configuration to detect truncated or
mismatched bitstream errors and aborts cleanly with -EPROTO.

These changes ensure proper error handling for truncated bitstreams and
prevent system hangs due to incomplete DMA transfers.

Signed-off-by: Ang Tien Sung <tien.sung.ang@altera.com>
Signed-off-by: Murugasen Krishnan, Kuhanh <kuhanh.murugasen.krishnan@altera.com>

---
 drivers/fpga/altera-cvp.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 5af0bd33890c..390ecb8359ac 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -80,6 +80,7 @@ struct altera_cvp_conf {
 	u8			numclks;
 	u32			sent_packets;
 	u32			vsec_offset;
+	u8			*send_buf;
 	const struct cvp_priv	*priv;
 };
 
@@ -452,7 +453,10 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
 		}
 
 		len = min(conf->priv->block_size, remaining);
-		altera_cvp_send_block(conf, data, len);
+		/* Copy the requested host data into the transmit buffer */
+		memcpy(conf->send_buf, data, len);
+		altera_cvp_send_block(conf, (const u32 *)conf->send_buf,
+				      conf->priv->block_size);
 		data += len / sizeof(u32);
 		done += len;
 		remaining -= len;
@@ -491,10 +495,13 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
 	if (ret)
 		return ret;
 
-	/* STEP 16 - check CVP_CONFIG_ERROR_LATCHED bit */
-	altera_read_config_dword(conf, VSE_UNCOR_ERR_STATUS, &val);
-	if (val & VSE_UNCOR_ERR_CVP_CFG_ERR) {
-		dev_err(&mgr->dev, "detected CVP_CONFIG_ERROR_LATCHED!\n");
+	/*
+	 * STEP 16 - If bitstream error (truncated/miss-matched),
+	 * we shall exit here.
+	 */
+	ret = altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
+	if (ret || (val & VSE_CVP_STATUS_CFG_ERR)) {
+		dev_err(&mgr->dev, "CVP_CONFIG_ERROR!\n");
 		return -EPROTO;
 	}
 
@@ -660,6 +667,13 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, mgr);
 
+	/* Allocate the 4096 block size transmit buffer */
+	conf->send_buf = devm_kzalloc(&pdev->dev, conf->priv->block_size, GFP_KERNEL);
+	if (!conf->send_buf) {
+		ret = -ENOMEM;
+		fpga_mgr_unregister(mgr);
+		goto err_unmap;
+	}
 	return 0;
 
 err_unmap:
-- 
2.25.1


